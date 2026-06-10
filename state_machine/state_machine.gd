extends Node

signal state_changed(last_state:Node, current_state: Node)

@export var start_state: NodePath

var states_map := {}
var states_stack := []
var current_state: Node = null
var _active: bool = false:
	set(value):
		_active = value
		set_active(value)

func _enter_tree() -> void:
	var initial_state: Node
	# set a initial_state in Inspector, or the start_state is the first child of StateMachine
	if start_state.is_empty():
		initial_state = get_child(0)
	else:
		initial_state = get_node(start_state)
	
	for child in get_children():
		var err: bool = child.finished.connect(_change_state)
		if err:
			printerr(err)
	
	initialize(initial_state)

func initialize(initial_state: Node) -> void:
	_active = true
	states_stack.push_front(initial_state)
	current_state = states_stack[0]
	current_state.enter()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_active(active: bool) -> void:
	set_physics_process(active)
	set_process_input(active)
	if not _active:
		states_stack = []
		current_state = null

func _change_state(next_state_name: StringName) -> void:
	if not _active:
		return
	current_state.exit()
	states_stack[0] = states_map[next_state_name] # Get state Node from state string name
	
	current_state = states_stack[0]
	state_changed.emit(current_state) # fire the state_changed signal
	
	current_state.enter()

func _physics_process(delta: float) -> void:
	current_state.update(delta)
	
func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if not _active:
		return
	
	current_state._on_animation_finished(anim_name)
