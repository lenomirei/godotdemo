extends "res://player/states/motion/motion.gd"


var speed := 0.0
var velocity := Vector2()

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("jump"):
		finished.emit(PLAYER_STATE.JUMPING)
		
	if _input_event.is_action_pressed("attack"):
		finished.emit(PLAYER_STATE.ATTACKING)
	
	return super.handle_input(_input_event)
