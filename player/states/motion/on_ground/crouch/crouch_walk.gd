extends "res://player/states/motion/on_ground/crouch/crouch.gd"

func enter() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("crouch_walk" + suffix)


func update(_delta: float) -> void:
	var direction :Vector2 = get_input_direction()
	if !direction.x:
		owner.velocity.x = move_toward(owner.velocity.x, 0, CROUCH_SPEED)
		finished.emit(PLAYER_STATE.CROUCHIDLE)
	else:
		update_look_direction(get_facing_left())
		# Respond to horizontal movement both in the air and on the ground.
		owner.velocity.x = direction.x * CROUCH_SPEED
