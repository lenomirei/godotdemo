extends "res://monster/monster_state.gd"


func update_look_direction(left: bool) -> void:
	if owner.facing_left != left:
		owner.facing_left = left
	owner.get_node(^"Sprite2D").flip_v = false
	owner.get_node(^"Sprite2D").flip_h = false if owner.facing_left else true
	owner.get_node(^"Direction").scale.x = 1 if owner.facing_left else -1

func get_look_direction() -> Vector2:
	var direction :Vector2 = Vector2.ZERO
	if not owner.facing_left:
		direction = Vector2.RIGHT
	else:
		direction = Vector2.LEFT
	return direction

func update(_delta: float) -> void:
	super.update(_delta)
