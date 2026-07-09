extends "res://player/states/motion/motion.gd"


func update(_delta: float) -> void:
	# gravity
	owner.velocity += owner.get_gravity() * _delta
	
	# 横向阻力
	var direction :Vector2 = get_input_direction()
	if !direction.x:
		owner.velocity.x = move_toward(owner.velocity.x, 0, 10)
	
	super.update(_delta)
