extends "res://player/states/motion/in_air/in_air.gd"

const JUMP_VELOCITY = 400.0

func init(speed: float, velocity: float) -> void:
	pass
	
func enter() -> void:
	update_look_direction(get_facing_left())
	player_motor.jump(JUMP_VELOCITY)
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	animation_player.play("jump" + suffix)
	
func update(_delta: float) -> void:
	if owner.is_on_floor() && owner.velocity.y == 0:
		finished.emit(PLAYER_STATE.IDLE)
	elif owner.velocity.y > 450:
		finished.emit(PLAYER_STATE.FALL)
	
	super.update(_delta)
