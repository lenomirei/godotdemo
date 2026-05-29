extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum WeaponState { HOLSTERED, DRAWN }
var current_status: WeaponState = WeaponState.HOLSTERED
var facing_left = false
var was_on_floor = false
var state: State = State.IDLE

enum State { IDLE, WALK, ATTACKING, JUMPING, FALL, LANDING }

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drawn_weapon"):
		if current_status == WeaponState.HOLSTERED:
			current_status = WeaponState.DRAWN
		else:
			current_status = WeaponState.HOLSTERED
	

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction < 0:
		facing_left = true
	elif direction > 0:
		facing_left = false
	
	move_and_slide()
	if !was_on_floor and is_on_floor():
		on_landing()
	was_on_floor = is_on_floor()
	
	update_animation()

func on_landing() -> void:
	
	velocity = Vector2(0, 0)
	$AnimationPlayer.play("landing")
	

func update_animation() -> void:
	var animation_name = get_animation_name()
	$AnimationPlayer.play(animation_name)
	
func get_animation_name() -> String:
	var suffix = "_weapon" if current_status == WeaponState.DRAWN else ""
	$Sprite2D.flip_v = false
	$Sprite2D.flip_h = true if facing_left else false
	var animation_name = "idle" + suffix
	#if attacking:
		#animation_name = "attack"
	if velocity.y != 0:
		if velocity.y > 600:
			animation_name = "fall" + suffix
		else:
			animation_name = "jump"
		#animation_name = "fall" if velocity.y > 0 else "jump"
		return animation_name
	
	if velocity.x != 0 && is_on_floor():
		animation_name = "walk" + suffix
	return animation_name
