extends "res://player/states/motion/motion.gd"

func enter() -> void:
	player_motor.stop_horization()
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	animation_player.play("hit" + suffix)

func update(_delta: float) -> void:
	pass

func handle_input(_input_event: InputEvent) -> void:
	pass

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name.begins_with("hit"):
		finished.emit(PLAYER_STATE.IDLE)
