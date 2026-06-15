extends "res://player/player_state.gd"

const SPEED = 300.0

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("climb"):
		try_climb()
	
func get_input_direction() -> Vector2:
	return Vector2(
			Input.get_axis(&"ui_left", &"ui_right"),
			Input.get_axis(&"ui_up", &"ui_down")
		) 
		
func get_facing_left() -> bool:
	var input_direction := get_input_direction()
	if input_direction.x == 0:
		return owner.facing_left
	else:
		return true if input_direction.x < 0 else false

func update_look_direction(left: bool) -> void:
	if owner.facing_left != left:
		owner.facing_left = left
	owner.get_node(^"Sprite2D").flip_v = false
	owner.get_node(^"Sprite2D").flip_h = true if owner.facing_left else false

func update(_delta: float) -> void:
	# handle input and speed in x direction
	var direction :Vector2 = get_input_direction()
	update_look_direction(get_facing_left())
	if direction.x:
		# Respond to horizontal movement both in the air and on the ground.
		owner.velocity.x = direction.x * SPEED

func is_on_ladder() -> bool:
	var tilemap: TileMapLayer = owner.get_parent().get_node(^"TileMapLayer")
	var cell = tilemap.local_to_map(
		tilemap.to_local(owner.global_position)
	)
	var tile_data = tilemap.get_cell_tile_data(cell)
	if tile_data == null:
		return false
	return tile_data.get_custom_data("ladder")

func try_climb() -> void:
	if is_on_ladder():
		finished.emit(PLAYER_STATE.LADDERING)
