extends "res://player/states/motion/in_air/in_air.gd"

const JUMP_VELOCITY = -400.0

func init(speed: float, velocity: float) -> void:
	pass
	
func enter() -> void:
	update_look_direction(get_facing_left())
	owner.velocity.y = JUMP_VELOCITY
	owner.get_node(^"AnimationPlayer").play("jump")
	
func update(_delta: float) -> void:
	if owner.is_on_floor() && owner.velocity.y == 0:
		var input_direction: Vector2 = get_input_direction()
		if input_direction.x != 0:
			finished.emit(PLAYER_STATE.WALK)
		else:
			finished.emit(PLAYER_STATE.IDLE)
	elif owner.velocity.y > 450:
		finished.emit(PLAYER_STATE.FALL)
	
	super.update(_delta)
