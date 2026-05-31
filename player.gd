extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum WeaponState { HOLSTERED, DRAWN }
var weapon_state: WeaponState = WeaponState.HOLSTERED
var facing_left = false
var was_on_floor = false
var state: State = State.IDLE
var action_lock = false
var attack_combo = 0
var next_state = State.INVALID

enum State { IDLE, WALK, ATTACKING, JUMPING, FALL, LANDING, INVALID }

func try_attack() -> void:
	if action_lock:
		next_state = State.ATTACKING
		return
	if weapon_state == WeaponState.HOLSTERED:
		weapon_state = WeaponState.DRAWN
		
	state = State.ATTACKING
	action_lock = true
	
	if state == State.ATTACKING:
		pass
	else:
		state = State.ATTACKING
	
	if !$AttackComboTimer.is_stopped():
		$AttackComboTimer.stop()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("drawn_weapon"):
		if weapon_state == WeaponState.HOLSTERED:
			weapon_state = WeaponState.DRAWN
		else:
			weapon_state = WeaponState.HOLSTERED
	
	if event.is_action_pressed("attack"):
		try_attack()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not action_lock:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction and !action_lock:
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
	update_state()
	update_animation()

func on_landing() -> void:
	state = State.LANDING
	action_lock = true
	velocity = Vector2(0, 0)
	$AnimationPlayer.play("landing")

func update_state() -> void:
	if action_lock:
		return
	if velocity.y != 0:
		if velocity.y > 600:
			state = State.FALL
		else:
			state = State.JUMPING
		return
	
	if velocity.x != 0 and is_on_floor():
		state = State.WALK
		return
		
	state = State.IDLE

func update_animation() -> void:
	var animation_name = get_animation_name()
	$AnimationPlayer.play(animation_name)
	
func get_animation_name() -> String:
	var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	$Sprite2D.flip_v = false
	$Sprite2D.flip_h = true if facing_left else false
	var animation_name = "idle" + suffix
	match state:
		State.IDLE:
			animation_name = "idle" + suffix
		State.WALK:
			animation_name = "walk" + suffix
		State.JUMPING:
			animation_name = "jump"
		State.FALL:
			animation_name = "fall" + suffix
		State.LANDING:
			animation_name = "landing" + suffix
		State.ATTACKING:
			animation_name = "attack" + String.num_int64(attack_combo + 1)
	return animation_name

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with("landing"):
		action_lock = false
	if anim_name.begins_with("attack") and next_state != State.ATTACKING:
		action_lock = false
		$AttackComboTimer.start()
	elif anim_name.begins_with("attack") and next_state == State.ATTACKING:
		state = next_state
		next_state = State.INVALID
		action_lock = true
		attack_combo += 1
	
	if anim_name == "attack4":
		attack_combo = 0
		print("attack combo is finished")
		
	#if next_state != State.INVALID:
		#state = next_state
		#next_state = State.INVALID
		#if state == State.ATTACKING:
			#print("attack continue")
			#action_lock = true
			#attack_combo += 1


func _on_attack_combo_timer_timeout() -> void:
	attack_combo = 0
