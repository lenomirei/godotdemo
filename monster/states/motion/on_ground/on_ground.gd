extends "res://monster/states/motion/motion.gd"

func update(_delta: float) -> void:
	var player_detect_area: Area2D = owner.get_node(^"PlayerDetectArea")
	
	var bodies: Array = player_detect_area.get_overlapping_bodies()
	if not bodies.is_empty():
		if bodies[0] is Player:
			finished.emit(MONSTER_STATE.CHASE)
			
	super.update(_delta)
