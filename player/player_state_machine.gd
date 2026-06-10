extends "res://state_machine/state_machine.gd"

var PLAYER_STATE: Dictionary = preload("res://player/player_state.gd").PLAYER_STATE

@onready var idle: Node = $Idle
@onready var walk: Node = $Walk
@onready var jumping: Node = $Jumping
@onready var fall: Node = $Fall
@onready var attack: Node = $Attack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	states_map = {
		PLAYER_STATE.IDLE: idle,
		PLAYER_STATE.WALK: walk,
		PLAYER_STATE.JUMPING: jumping,
		PLAYER_STATE.FALL: fall,
		PLAYER_STATE.ATTACKING: attack,
	}

func _change_state(next_state_name: StringName) -> void:
	if not _active:
		return
		
	#if next_state_name == "jump" and current_state.name == "walk":
		#jumping.init()
	
	super._change_state(next_state_name)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	owner.move_and_slide() # This could also be delegated to each state.
	
