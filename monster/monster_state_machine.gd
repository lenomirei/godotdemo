extends "res://state_machine/state_machine.gd"

var MONSTER_STATE: Dictionary = preload("res://monster/monster_state.gd").MONSTER_STATE

@onready var idle: Node = $Idle
@onready var run: Node = $Run
@onready var hit: Node = $Hit
@onready var die: Node = $Die

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	states_map = {
		MONSTER_STATE.IDLE: idle,
		MONSTER_STATE.RUN: run,
		MONSTER_STATE.HIT: hit,
		MONSTER_STATE.DIE: die,
	}

func _change_state(next_state_name: StringName) -> void:
	if not _active:
		return
		
	super._change_state(next_state_name)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	owner.move_and_slide() # This could also be delegated to each state.

func handle_command() -> void:
	current_state.finished.emit(MONSTER_STATE.HIT);
