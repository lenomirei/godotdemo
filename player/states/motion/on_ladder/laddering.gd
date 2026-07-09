extends "res://player/states/motion/on_ladder/on_ladder.gd"


func enter() -> void:
	owner.velocity.x = 0
	owner.get_node(^"AnimationPlayer").play("laddering")
	
	
func update(_delta: float) -> void:
	var animation_player = owner.get_node(^"AnimationPlayer")
	var ladder_direction :Vector2 = get_input_direction()
	if ladder_direction.y == 0:
		animation_player.speed_scale = 0
	else:
		animation_player.speed_scale = 1
	
	super.update(_delta)

func exit() -> void:
	var animation_player = owner.get_node(^"AnimationPlayer")
	animation_player.speed_scale = 1
	
