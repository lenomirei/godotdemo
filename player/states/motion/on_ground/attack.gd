extends "res://player/states/motion/on_ground/on_ground.gd"

var attack_combo = 1
var handle_pre_attack: bool = false

func enter() -> void:
	if get_weapon_state() != WeaponState.DRAWN:
		change_weapon_state()
	handle_pre_attack = false
	if !$AttackComboTimer.is_stopped():
		attack_combo += 1
		$AttackComboTimer.stop()
	if attack_combo > 4:
			attack_combo = 1
	owner.get_node(^"AnimationPlayer").play("attack" + String.num_int64(attack_combo))
	
func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("attack"):
		handle_pre_attack = true
		
	if _input_event.is_action_pressed("rolling"):
		finished.emit(PLAYER_STATE.ROLLING)

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name.begins_with("attack") and handle_pre_attack:
		attack_combo += 1
		
		finished.emit(PLAYER_STATE.ATTACK)
	elif _anim_name.begins_with("attack"):
		# attack animation finished and no preinput to continue attacking
		# start the combo timer
		$AttackComboTimer.start()
		finished.emit(PLAYER_STATE.IDLE)

func _on_attack_combo_timer_timeout() -> void:
	attack_combo = 1
	
func update(_delta: float) -> void:
	# Temporarily prevent movement while attacking.
	owner.velocity.x = 0
