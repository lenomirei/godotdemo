extends "res://state_machine/state.gd"
enum State { IDLE, WALK, ATTACKING, JUMPING, FALL, LANDING, ROLLING, LADDERING, INVALID }


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
