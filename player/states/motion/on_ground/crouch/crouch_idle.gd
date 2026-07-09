extends "res://player/states/motion/on_ground/crouch/crouch.gd"

func enter() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("crouch_idle" + suffix)

func update(_delta: float) -> void:
	var input_direction: Vector2 = get_input_direction()
	if input_direction.x != 0:
		finished.emit(PLAYER_STATE.CROUCHWALK)
	
	super.update(_delta)
