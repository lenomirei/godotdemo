extends "res://player/states/motion/motion.gd"

const LADDER_SPEED = 100.0

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("jump"):
		finished.emit(PLAYER_STATE.JUMPING)

func update(_delta: float) -> void:
	if !is_on_ladder():
		finished.emit(PLAYER_STATE.IDLE)
		return
	# handle input and speed in x direction
	var direction :Vector2 = get_input_direction()
	update_look_direction(get_facing_left())
	if direction.y:
		# Respond to horizontal movement both in the air and on the ground.
		owner.velocity.y = direction.y * LADDER_SPEED
		if direction.y == 1 && owner.is_on_floor():
			finished.emit(PLAYER_STATE.IDLE)
	else:
		owner.velocity.y = move_toward(owner.velocity.y, 0, LADDER_SPEED)
