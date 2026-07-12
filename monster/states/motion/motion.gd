extends "res://monster/monster_state.gd"


func update_look_direction(left: bool) -> void:
	if owner.facing_left != left:
		owner.facing_left = left
	owner.get_node(^"Sprite2D").flip_v = false
	owner.get_node(^"Sprite2D").flip_h = true if owner.facing_left else false


func update(_delta: float) -> void:
	# handle input and speed in x direction
	var direction :Vector2 = Vector2.ZERO
	if owner.velocity.x > 0:
		direction = Vector2.RIGHT
	elif owner.velocity.x < 0:
		direction = Vector2.LEFT
	
	if direction.x:
		update_look_direction(owner.facing_left)
