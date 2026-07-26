extends "res://monster/states/motion/on_ground/on_ground.gd"

const MONSTER_SPEED: int = 100

func enter() -> void:
	animation_player.play("run")

func update(_delta: float) -> void:
	#var floor_detect_ray_left: RayCast2D = owner.get_node(^"FloorDetectRayLeft");
	#var floor_detect_ray_right: RayCast2D = owner.get_node(^"FloorDetectRayRight");
	var direction: Vector2 = get_look_direction()
	owner.velocity.x = direction.x * MONSTER_SPEED
	#if not floor_detect_ray_left.is_colliding() and direction == Vector2.LEFT:
		#finished.emit(MONSTER_STATE.IDLE)
	#elif not floor_detect_ray_right.is_colliding() and direction == Vector2.RIGHT:
		#finished.emit(MONSTER_STATE.IDLE)
	
	var player_detect_ray: RayCast2D = owner.get_node(^"Direction/PlayerDetectRay")
	
	if player_detect_ray.is_colliding() and player_detect_ray.collide_with_bodies and player_detect_ray.get_collider() is Player:
		var player:Player = player_detect_ray.get_collider()
		var d: float = player.position.distance_to(owner.position)
		if d < 100:
			finished.emit(MONSTER_STATE.ATTACK)

func exit() -> void:
	owner.velocity.x = 0
