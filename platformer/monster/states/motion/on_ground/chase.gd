extends "res://monster/states/motion/on_ground/on_ground.gd"

const MONSTER_SPEED: int = 100

func enter() -> void:
	animation_player.play("run")

func update(_delta: float) -> void:
	var monster: Monster = owner as Monster
	var player: Player = monster.player
	if player:
		var direction := monster.global_position.direction_to(player.global_position).normalized()
		if direction.x < 0:
			update_look_direction(true)
		else:
			update_look_direction(false)
		var distance: float = player.position.distance_to(monster.position)
		if distance < 100:
			finished.emit(MONSTER_STATE.ATTACK)
		else:
			owner.velocity.x = get_look_direction().x * MONSTER_SPEED

func exit() -> void:
	owner.velocity.x = 0
