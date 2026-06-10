extends "res://player/player_state.gd"

var attack_combo = 1
var handle_next_attack: bool = false

func enter() -> void:
	handle_next_attack = false
	if !$AttackComboTimer.is_stopped():
		attack_combo += 1
		$AttackComboTimer.stop()
	owner.get_node(^"AnimationPlayer").play("attack" + String.num_int64(attack_combo))
	
func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("attack"):
		handle_next_attack = true

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name.begins_with("attack") and handle_next_attack:
		attack_combo += 1
		if attack_combo > 4:
			attack_combo = 1
		finished.emit(PLAYER_STATE.ATTACKING)
	elif _anim_name.begins_with("attack"):
		# attack animation finished and no preinput to continue attacking
		# start the combo timer
		$AttackComboTimer.start()
		finished.emit(PLAYER_STATE.IDLE)


func _on_attack_combo_timer_timeout() -> void:
	attack_combo = 1
