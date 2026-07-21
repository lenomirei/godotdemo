extends "res://player/states/motion/motion.gd"

func enter() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("hit" + suffix)

func update(_delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	pass

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name.begins_with("hit"):
		finished.emit(PLAYER_STATE.IDLE)
