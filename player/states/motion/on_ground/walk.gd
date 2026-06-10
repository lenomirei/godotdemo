extends "res://player/states/motion/on_ground/on_ground.gd"

func enter():
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("walk" + suffix)
	var input_direction := get_input_direction()
	update_look_direction(get_facing_left())
	

func handle_input(_input_event: InputEvent) -> void:
	if _input_event is InputEventKey:
		return super.handle_input(_input_event)

func refresh_animation() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("walk" + suffix)
