extends "res://player/states/motion/on_ground/crouch/crouch.gd"

func enter() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	animation_player.play("crouch_in" + suffix)

func _on_animation_finished(_anim_name: String) -> void:
	finished.emit(PLAYER_STATE.CROUCHIDLE)
