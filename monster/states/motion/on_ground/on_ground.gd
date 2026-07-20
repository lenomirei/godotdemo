extends "res://monster/states/motion/motion.gd"

func update(_delta: float) -> void:
	var player_detect_ray: RayCast2D = owner.get_node(^"Direction/PlayerDetectRay")
	
	if player_detect_ray.is_colliding() and player_detect_ray.collide_with_bodies and player_detect_ray.get_collider() is Player:
		var player: Player = player_detect_ray.get_collider() as Player
		finished.emit(MONSTER_STATE.CHASE)
			
	super.update(_delta)
