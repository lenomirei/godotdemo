extends CharacterBody2D

class_name Monster

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var patrol: bool = true;

var facing_left = true

func hit() -> void:
	print("get hit")
	get_node(^"StateMachine").handle_command()
