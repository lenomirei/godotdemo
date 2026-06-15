extends "res://player/states/motion/motion.gd"


func update(_delta: float) -> void:
	owner.velocity += owner.get_gravity() * _delta
	
	super.update(_delta)
