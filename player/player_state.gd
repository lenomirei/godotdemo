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
	
func set_weapon_state(state: WeaponState):
	owner.weapon_state = state
