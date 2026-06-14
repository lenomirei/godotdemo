extends "res://player/states/motion/in_air/in_air.gd"

var last_yvelocity
func enter() -> void:
	owner.get_node(^"AnimationPlayer").play("fall")


func update(_delta: float) -> void:
	if get_on_floor():
		if last_yvelocity >= 450:
			finished.emit(PLAYER_STATE.LANDING)
		else:
			var input_direction = get_input_direction()
			finished.emit(PLAYER_STATE.IDLE if input_direction.x == 0 else PLAYER_STATE.WALK)
	else:
		last_yvelocity = owner.velocity.y
	
	super.update(_delta)
