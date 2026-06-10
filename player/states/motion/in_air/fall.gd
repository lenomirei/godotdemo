extends "res://player/states/motion/in_air/in_air.gd"


func enter() -> void:
	owner.get_node(^"AnimationPlayer").play("fall")


func update(_delta: float) -> void:
	if get_on_floor():
		if owner.velocity.y >= 450:
			var input_direction = get_input_direction()
			finished.emit(PLAYER_STATE.IDLE if input_direction.x == 0 else PLAYER_STATE.WALK)
			#finished.emit(PLAYER_STATE.LANDING)
		else:
			var input_direction = get_input_direction()
			finished.emit(PLAYER_STATE.IDLE if input_direction.x == 0 else PLAYER_STATE.WALK)
	
	super.update(_delta)
