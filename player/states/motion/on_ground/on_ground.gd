extends "res://player/states/motion/motion.gd"

var speed := 0.0
var velocity := Vector2()

func can_jump() -> bool:
	return true

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("jump") and can_jump():
		finished.emit(PLAYER_STATE.JUMP)
		
	if _input_event.is_action_pressed("attack"):
		finished.emit(PLAYER_STATE.ATTACK)
		
	if _input_event.is_action_pressed("drawn_weapon"):
		change_weapon_state()
	
	if _input_event.is_action_pressed("rolling"):
		finished.emit(PLAYER_STATE.ROLLING)
		
	if _input_event.is_action_pressed("crouch"):
		finished.emit(PLAYER_STATE.CROUCHIN)
	
	return super.handle_input(_input_event)
	
func update(_delta: float) -> void:
	if !get_on_floor():
		# switch to in air state
		finished.emit(PLAYER_STATE.FALL)
			
	super.update(_delta)
