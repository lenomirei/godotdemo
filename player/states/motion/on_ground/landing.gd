extends "res://player/states/motion/on_ground/on_ground.gd"

func enter() -> void:
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	owner.get_node(^"AnimationPlayer").play("landing" + suffix)
	
func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("rolling"):
		finished.emit(PLAYER_STATE.ROLLING)

func update(_delta: float) -> void:
	# Temporarily prevent movement while landing.
	owner.velocity.x = 0

func _on_animation_finished(_anim_name: String) -> void:
	finished.emit(PLAYER_STATE.IDLE)
