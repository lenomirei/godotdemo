extends "on_ground.gd"

func enter() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("idle" + suffix)

func update(_delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x != 0:
		finished.emit(PLAYER_STATE.WALK)
	
	super.update(_delta)

func refresh_animation() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("idle" + suffix)
