extends Node

class_name PlayerMotor

@export var MOVE_SPEED: int = 300
@export var CROUCHING_SPEED: int = 150

@onready var player: Player = get_parent() as Player

func get_input_direction() -> Vector2:
	return Vector2(
			Input.get_axis(&"ui_left", &"ui_right"),
			Input.get_axis(&"ui_up", &"ui_down")
		)
		
func get_facing_left() -> bool:
	var input_direction := get_input_direction()
	if input_direction.x == 0:
		return player.facing_left
	else:
		return true if input_direction.x < 0 else false

func update_look_direction(left: bool) -> void:
	if owner.facing_left != left:
		owner.facing_left = left
	player.get_node(^"Sprite2D").flip_v = false
	player.get_node(^"Sprite2D").flip_h = true if owner.facing_left else false
	player.get_node(^"Weapon").scale.x = -1 if owner.facing_left else 1

func move_horization(delta: float) -> void:
	var direction :Vector2 = get_input_direction()
	if direction.x:
		update_look_direction(get_facing_left())
		# Respond to horizontal movement both in the air and on the ground.
		owner.velocity.x = direction.x * MOVE_SPEED
	else:
		brake_horization(delta)

func brake_horization(delta: float) -> void:
	player.velocity.x = move_toward(owner.velocity.x, 0, owner.velocity.x)
	
func stop_horization() -> void:
	player.velocity.x = 0
	
func jump(speed: float) -> void:
	player.velocity.y = -speed

func apply_gravity(delta: float, scale: int = -1.0) -> void:
	if player.is_on_floor():
		return
	player.velocity += player.get_gravity() * delta
