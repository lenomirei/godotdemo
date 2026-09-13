extends "res://monster/states/motion/on_ground/on_ground.gd"

func enter() -> void:
	var animation_player: AnimationPlayer = animation_player;
	animation_player.play("attack")

func _on_animation_finished(_anim_name: String) -> void:
	finished.emit(MONSTER_STATE.IDLE)

func update(_delta: float) -> void:
	pass
