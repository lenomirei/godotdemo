extends "res://player/player_state.gd"

const SPEED = 300.0
const CROUCH_SPEED = 150.0

@onready var player_motor: PlayerMotor = owner.get_node(^"PlayerMotor")
@onready var animation_player: AnimationPlayer = owner.get_node(^"AnimationPlayer")

func handle_input(_input_event: InputEvent) -> void:
	if _input_event.is_action_pressed("climbup") || _input_event.is_action_pressed("climbdown"):
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
	owner.get_node(^"Weapon").scale.x = -1 if owner.facing_left else 1

func update(_delta: float) -> void:
	super.update(_delta)

func is_on_ladder() -> bool:
	var tilemap: TileMapLayer = owner.get_parent().get_node(^"TileMapLayer")
	var shape_node = owner.get_node(^"CollisionShape2D")
	var shape = shape_node.shape
	var center = shape_node.global_position
	var points: Array[Vector2] = [center]

	if shape is CapsuleShape2D:
		var capsule := shape as CapsuleShape2D
		var half_width := capsule.radius
		var half_height := capsule.height * 0.5
		points.append(center + Vector2(0, -half_height))
		points.append(center + Vector2(0, half_height))
		points.append(center + Vector2(-half_width, 0))
		points.append(center + Vector2(half_width, 0))
	for world_position in points:
		var cell = tilemap.local_to_map(tilemap.to_local(world_position))
		var tile_data = tilemap.get_cell_tile_data(cell)
		if tile_data != null and tile_data.get_custom_data("ladder"):
			return true

	return false
	
func ladder_is_by_feet() -> bool:
	var tilemap: TileMapLayer = owner.get_parent().get_node(^"TileMapLayer")
	var raycast: RayCast2D = owner.get_node(^"LadderDetectRay")
	var point: Vector2 = raycast.get_collision_point()
	var local: Vector2 = tilemap.to_local(point)
	var coords: Vector2i = tilemap.local_to_map(local)
	var tile_data = tilemap.get_cell_tile_data(coords)
	if tile_data:
		var ladder: Variant = tile_data.get_custom_data("ladder")
		return ladder as bool
	else:
		return false

func try_climb() -> void:
	if is_on_ladder():
		finished.emit(PLAYER_STATE.LADDERING)
	elif ladder_is_by_feet():
		finished.emit(PLAYER_STATE.LADDERING)

func refresh_animation() -> void:
	var animation_player: AnimationPlayer = animation_player
	var weapon_state = get_weapon_state()
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	var animation_name = PLAYER_STATE[name.to_upper()] + suffix;
	print("switch to " + animation_name)
	if animation_player.has_animation(animation_name):
		animation_player.play(animation_name)
