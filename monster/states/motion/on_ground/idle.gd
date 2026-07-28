extends "res://monster/states/motion/on_ground/on_ground.gd"

func enter() -> void:
	animation_player.play("idle")
	if owner.patrol:
		$"IdleTimer".start();

func _on_idle_timer_timeout() -> void:
	# turn left or turn right
	update_look_direction(not owner.facing_left)
	finished.emit(MONSTER_STATE.RUN)

func exit() -> void:
	var idle_timer: Timer = $"IdleTimer"
	if not idle_timer.is_stopped():
		idle_timer.stop()
