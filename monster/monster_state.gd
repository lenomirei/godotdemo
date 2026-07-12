extends "res://state_machine/state.gd"


const MONSTER_STATE: Dictionary[StringName, StringName] = {
	&"IDLE": &"idle",
	&"ATTACK": &"attack",
	&"HIT": &"hit",
	&"RUN": &"run",
}
