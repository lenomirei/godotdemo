extends "res://state_machine/state.gd"

class_name MonsterState

const MONSTER_STATE: Dictionary[StringName, StringName] = {
	&"IDLE": &"idle",
	&"ATTACK": &"attack",
	&"HIT": &"hit",
	&"RUN": &"run",
	&"DIE": &"die",
	&"CHASE": &"chase",
	&"STUN": &"stun",
}

enum MonsterStateMachineCommand { HIT, DIE, ATTACK }
