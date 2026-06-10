extends "res://state_machine/state.gd"
enum WeaponState { HOLSTERED, DRAWN }

const PLAYER_STATE: Dictionary[StringName, StringName] = {
	&"IDLE": &"idle",
	&"WALK": &"walk",
	&"ATTACKING": &"attacking",
	&"JUMPING": &"jumping",
	&"FALL": &"fall",
	&"LANDING": &"landing",
	&"ROLLING": &"rolling",
	&"LADDERING": &"laddering",
}

func get_on_floor() -> bool:
	return owner.is_on_floor()

func get_weapon_state() -> WeaponState:
	return owner.weapon_state
	
func change_weapon_state():
	if get_weapon_state() != WeaponState.DRAWN:
		owner.weapon_state = WeaponState.DRAWN
	else:
		owner.weapon_state = WeaponState.HOLSTERED
		
	refresh_animation()
	
func refresh_animation() -> void:
	pass
