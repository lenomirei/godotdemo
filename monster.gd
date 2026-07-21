extends CharacterBody2D

class_name Monster

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var patrol: bool = true;
@onready var hp_bar: TextureProgressBar = $"HpBar"
@onready var show_timer: Timer = $"HpBar/ShowTimer"

var facing_left = true

func hit(damage: int) -> void:
	print("get hit")
	hp_bar.visible = true
	hp_bar.value -= damage;
	
	show_timer.stop()
	show_timer.start()
	
	if hp_bar.value <= 0:
		$"CollisionShape2D".set_deferred("disabled", true)
		$"Direction/PlayerDetectRay".set_deferred("enabled", false)
		get_node(^"StateMachine").handle_command(MonsterState.MonsterStateMachineCommand.DIE)
	else:
		get_node(^"StateMachine").handle_command(MonsterState.MonsterStateMachineCommand.HIT)


func _on_show_timer_timeout() -> void:
	hp_bar.visible = false


func _on_attack_hit_box_body_entered(body: Node2D) -> void:
	if body is Player:
		print("player hit")
		body as Player
		body.on_hit(1)
