extends "on_ground.gd"

func enter() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("idle" + suffix)
	
func handle_input(_input_event: InputEvent) -> void:
	return super.handle_input(_input_event)

func update(_delta: float) -> void:
	if !get_on_floor():
		finished.emit(PLAYER_STATE.FALL)
	else:
		var input_direction: Vector2 = get_input_direction()
		if input_direction.x != 0:
			finished.emit(PLAYER_STATE.WALK)
