extends "res://monster/states/motion/on_ground/on_ground.gd"


func enter() -> void:
	print("enter hit")
	owner.get_node(^"AnimationPlayer").play("hit")
