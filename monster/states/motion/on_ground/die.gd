extends "res://monster/states/motion/on_ground/on_ground.gd"

func enter() -> void:
	var animation_player:AnimationPlayer = owner.get_node(^"AnimationPlayer")
	animation_player.play("die")

func update(_delta: float) -> void:
	pass
	
func _on_animation_finished(_anim_name: String) -> void:
	var m: Monster = owner as Monster
	if (_anim_name.begins_with("die")):
		m.queue_free()
