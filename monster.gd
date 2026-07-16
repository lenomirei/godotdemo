extends CharacterBody2D

class_name Monster

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var patrol: bool = true;
@export var hp: int = 100;
@onready var hp_bar: ColorRect = $"HpBar"
@onready var hp_b: ColorRect = $"HpBar/Hp"
@onready var show_timer: Timer = $"HpBar/ShowTimer"

var facing_left = true

func hit() -> void:
	print("get hit")
	hp -= 10
	hp_bar.visible = true
	
	hp_b.size = Vector2(hp * 0.5, hp_b.size.y)
	
	show_timer.stop()
	show_timer.start()
	
	if hp <= 0:
		get_node(^"StateMachine").handle_command(MonsterState.MonsterStateMachineCommand.DIE)
	else:
		get_node(^"StateMachine").handle_command(MonsterState.MonsterStateMachineCommand.HIT)


func _on_show_timer_timeout() -> void:
	hp_bar.visible = false
