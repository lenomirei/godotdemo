extends "res://player/states/motion/on_ladder/on_ladder.gd"


func enter() -> void:
	owner.velocity.x = 0
	animation_player.play("laddering")
	
	
func update(_delta: float) -> void:
	var animation_player = animation_player
	var ladder_direction :Vector2 = get_input_direction()
	if ladder_direction.y == 0:
		animation_player.speed_scale = 0
	else:
		animation_player.speed_scale = 1
	
	super.update(_delta)

func exit() -> void:
	var animation_player = animation_player
	animation_player.speed_scale = 1
	
