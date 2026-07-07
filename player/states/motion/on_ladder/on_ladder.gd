extends "res://player/states/motion/motion.gd"

const LADDER_SPEED = 100.0

func is_ladder_at_world_position(world_position: Vector2) -> bool:
	var tilemap: TileMapLayer = owner.get_parent().get_node(^"TileMapLayer")
	var cell := tilemap.local_to_map(tilemap.to_local(world_position))
	var tile_data := tilemap.get_cell_tile_data(cell)

	return tile_data != null and tile_data.get_custom_data("ladder")
	
func get_collision_bottom_world_position() -> Vector2:
	var collision_shape: CollisionShape2D = owner.get_node(^"CollisionShape2D")
	var rect := collision_shape.shape.get_rect()

	var bottom_local := Vector2(
		rect.position.x + rect.size.x * 0.5,
		rect.position.y + rect.size.y
	)

	return collision_shape.to_global(bottom_local)

func has_ladder_below_feet() -> bool:
	var bottom_pos := get_collision_bottom_world_position()
	var check_distance := 8.0

	return is_ladder_at_world_position(bottom_pos + Vector2(0, check_distance))

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("jump"):
		finished.emit(PLAYER_STATE.JUMPING)

func update(_delta: float) -> void:
	if !is_on_ladder():
		finished.emit(PLAYER_STATE.IDLE)
		return
	# handle input and speed in x direction
	var direction :Vector2 = get_input_direction()
	update_look_direction(get_facing_left())
	if direction.y:
		owner.velocity.y = direction.y * LADDER_SPEED
		if direction.y == 1 && !has_ladder_below_feet():
			finished.emit(PLAYER_STATE.IDLE)
	else:
		owner.velocity.y = move_toward(owner.velocity.y, 0, LADDER_SPEED)

	if direction.x:
		owner.velocity.x = direction.x * LADDER_SPEED
	else:
		owner.velocity.x = move_toward(owner.velocity.x, 0, LADDER_SPEED)
	

	
	
