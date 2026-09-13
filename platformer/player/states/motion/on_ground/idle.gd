extends "on_ground.gd"

func enter() -> void:
	player_motor.stop_horization()
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	animation_player.play("idle" + suffix)

func update(_delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x != 0:
		finished.emit(PLAYER_STATE.WALK)
	
	super.update(_delta)
