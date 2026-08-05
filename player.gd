extends CharacterBody2D

class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var physics_attack_damage: int
@export var hp: int
@export var max_hp: int

signal health_changed(old_hp: int, hp: int)

enum WeaponState { HOLSTERED, DRAWN }
var weapon_state: WeaponState = WeaponState.HOLSTERED
var facing_left = false
var was_on_floor = false
#var state: State = State.IDLE
var action_lock = false
var attack_combo = 0

signal player_died
	
func on_hit(damage: int) -> void:
	health_changed.emit(hp, hp - 1)
	hp -= 1
	if hp <= 0:
		get_node(^"StateMachine").handle_command(PlayerState.PlayerStateMachineCommand.DIE)
	else:
		get_node(^"StateMachine").handle_command(PlayerState.PlayerStateMachineCommand.HIT)

func _on_attack_hit_box_body_entered(body: Node2D) -> void:
	var monster: Monster = body as Monster
	monster.hit(physics_attack_damage);
	
func handle_die_callback() -> void:
	player_died.emit()
