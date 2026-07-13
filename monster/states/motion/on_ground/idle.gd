extends "res://monster/states/motion/on_ground/on_ground.gd"

func enter() -> void:
	owner.get_node(^"AnimationPlayer").play("idle")
	
	$"IdleTimer".start();


func _on_idle_timer_timeout() -> void:
	# turn left or turn right
	update_look_direction(not owner.facing_left)
	finished.emit(MONSTER_STATE.RUN)
