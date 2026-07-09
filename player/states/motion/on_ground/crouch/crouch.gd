extends "res://player/states/motion/on_ground/on_ground.gd"

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("crouch"):
		try_stand()
	if _input_event.is_action_pressed("drawn_weapon"):
		change_weapon_state()

func try_stand() -> void:
	finished.emit(PLAYER_STATE.IDLE);