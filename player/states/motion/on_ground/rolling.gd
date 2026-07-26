extends "res://player/states/motion/on_ground/on_ground.gd"

const ROLLING_SPEED = 300.0

func enter() -> void:
	animation_player.play("rolling")

func handle_input(_input_event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	owner.velocity.x = ROLLING_SPEED * (-1 if get_facing_left() else 1)


func _on_animation_finished(_anim_name: String) -> void:
	player_motor.stop_horization()
	finished.emit(PLAYER_STATE.IDLE)
