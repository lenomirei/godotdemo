extends "res://monster/states/motion/on_ground/on_ground.gd"


func enter() -> void:
	print("enter hit")
	var animation_player: AnimationPlayer = owner.get_node(^"AnimationPlayer")
	if animation_player.current_animation == "hit":
		animation_player.seek(0, true, false)
	else:
		animation_player.play("hit")

func update(_delta: float) -> void:
	pass

func _on_animation_finished(_anim_name: String) -> void:
	if _anim_name.contains("hit"):
		finished.emit(MONSTER_STATE.RUN)
	else:
		super._on_animation_finished(_anim_name)
