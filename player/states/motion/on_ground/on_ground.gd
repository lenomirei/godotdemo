extends "res://player/states/motion/motion.gd"

var speed := 0.0
var velocity := Vector2()

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("jump"):
		finished.emit(PLAYER_STATE.JUMPING)
		
	if _input_event.is_action_pressed("attack"):
		finished.emit(PLAYER_STATE.ATTACKING)
		
	if _input_event.is_action_pressed("drawn_weapon"):
		change_weapon_state()
	
	if _input_event.is_action_pressed("rolling"):
		finished.emit(PLAYER_STATE.ROLLING)
	
	return super.handle_input(_input_event)
	
func update(_delta: float) -> void:
	if !get_on_floor():
		# switch to in air state
		finished.emit(PLAYER_STATE.FALL)
	else:
		# Idle state when no input on ground	
		var direction :Vector2 = get_input_direction()
		update_look_direction(get_facing_left())
		if !direction.x:
			owner.velocity.x = move_toward(owner.velocity.x, 0, SPEED)
			finished.emit(PLAYER_STATE.IDLE)
			
		super.update(_delta)
	
