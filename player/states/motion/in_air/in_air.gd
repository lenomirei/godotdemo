extends "res://player/states/motion/motion.gd"

func handle_input(_input_event: InputEvent) -> void:
	pass # maybe I can add double jump logic here?

func update(_delta: float) -> void:
	owner.velocity += owner.get_gravity() * _delta
	
	super.update(_delta)
