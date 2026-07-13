extends "res://monster/states/motion/on_ground/on_ground.gd"


func enter() -> void:
	print("enter hit")
	var animation_player: AnimationPlayer = owner.get_node(^"AnimationPlayer")
	if animation_player.current_animation == "hit":
		animation_player.seek(0, true, false)
	else:
		animation_player.play("hit")
