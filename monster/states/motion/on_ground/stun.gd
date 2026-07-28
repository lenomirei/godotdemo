extends "res://monster/states/motion/on_ground/on_ground.gd"

func enter() -> void:
	var animation_player: AnimationPlayer = animation_player
	animation_player.play("stun")
	
func update(_delta: float) -> void:
	pass
	
func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name.begins_with("stun"):
		finished.emit(MONSTER_STATE.CHASE)
