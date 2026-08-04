extends "res://player/states/motion/motion.gd"

func enter() -> void:
	player_motor.stop_horization()
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	animation_player.play("die" + suffix)

func update(_delta: float) -> void:
	pass

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name.begins_with("die"):
		owner.handle_die_callback()
		owner.queue_free()

func handle_input(_input_event: InputEvent) -> void:
	pass
	
