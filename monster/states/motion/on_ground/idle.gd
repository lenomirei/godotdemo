extends "res://monster/states/motion/on_ground/on_ground.gd"

func enter() -> void:
	owner.get_node(^"AnimationPlayer").play("idle")
