extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum WeaponState { HOLSTERED, DRAWN }
var weapon_state: WeaponState = WeaponState.HOLSTERED
var facing_left = false
var was_on_floor = false
#var state: State = State.IDLE
var action_lock = false
var attack_combo = 0
#var next_state = State.INVALID

#enum State { IDLE, WALK, ATTACKING, JUMPING, FALL, LANDING, ROLLING, LADDERING, INVALID }
#
#func is_on_ladder() -> bool:
	#var tilemap: TileMapLayer = get_parent().get_node("TileMapLayer")
	#var cell = tilemap.local_to_map(
		#tilemap.to_local(global_position)
	#)
	#var tile_data = tilemap.get_cell_tile_data(cell)
	#if tile_data == null:
		#return false
	#return tile_data.get_custom_data("ladder")
#
#func try_attack() -> void:
	#if action_lock:
		#next_state = State.ATTACKING
		#return
	#if weapon_state == WeaponState.HOLSTERED:
		#weapon_state = WeaponState.DRAWN
		#
	#action_lock = true
	#if state == State.ATTACKING:
		#pass
	#else:
		#print("state is " + String.num_int64(state) + " attack combo is " + String.num_int64(attack_combo))
		#state = State.ATTACKING
		#attack_combo += 1
	#
	#if !$AttackComboTimer.is_stopped():
		#$AttackComboTimer.stop()
#
#func try_rolling() -> void:
	#if state == State.ROLLING:
		#return
	#state = State.ROLLING
	#action_lock = true
#
#func try_climbing() -> void:
	#if !is_on_ladder():
		#return;
	#state = State.LADDERING
#
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("drawn_weapon"):
		#if weapon_state == WeaponState.HOLSTERED:
			#weapon_state = WeaponState.DRAWN
		#else:
			#weapon_state = WeaponState.HOLSTERED
	#
	#if event.is_action_pressed("attack"):
		#try_attack()
	#
	#if event.is_action_pressed("rolling"):
		#try_rolling()
		#
	#if event.is_action_pressed("climb"):
		#try_climbing()
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not action_lock:
		#velocity.y = JUMP_VELOCITY
	#
	#var ladder_direction := Input.get_axis("ui_up", "ui_down")
	#if is_on_ladder() and state == State.LADDERING:
		#if ladder_direction == 0:
			#$AnimationPlayer.speed_scale = 0
		#else:
			#$AnimationPlayer.speed_scale = 1
		#velocity.y = ladder_direction * SPEED
	#else:
		#$AnimationPlayer.speed_scale = 1
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction and !action_lock:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
	#
	#if state == State.ROLLING:
		#var rolling_direction = -1 if facing_left else 1;
		#velocity.x = SPEED * rolling_direction
		#
	#if direction < 0:
		#facing_left = true
	#elif direction > 0:
		#facing_left = false
	#
	#move_and_slide()
	#if !was_on_floor and is_on_floor() and state == State.FALL:
		#on_landing()
		#
	#was_on_floor = is_on_floor()
	#update_state()
	#update_animation()
#
#func on_landing() -> void:
	#state = State.LANDING
	#action_lock = true
	#velocity = Vector2(0, 0)
	#$AnimationPlayer.play("landing")
#
#func update_state() -> void:
	#if action_lock:
		#return
	#if !is_on_ladder() and state == State.LADDERING:
		#state = State.IDLE
		#return
	#elif is_on_ladder() and state == State.LADDERING:
		#state = State.LADDERING
		#return
	#if velocity.y != 0:
		#if velocity.y > 600:
			#state = State.FALL
		#else:
			#state = State.JUMPING
		#return
	#
	#if velocity.x != 0 and is_on_floor():
		#state = State.WALK
		#return
		#
	#state = State.IDLE
#
#func update_animation() -> void:
	#var animation_name = get_animation_name()
	#$AnimationPlayer.play(animation_name)
	#
#func get_animation_name() -> String:
	#var suffix = "_weapon" if weapon_state == WeaponState.DRAWN else ""
	#$Sprite2D.flip_v = false
	#$Sprite2D.flip_h = true if facing_left else false
	#var animation_name = "idle" + suffix
	#match state:
		#State.IDLE:
			#animation_name = "idle" + suffix
		#State.WALK:
			#animation_name = "walk" + suffix
		#State.JUMPING:
			#animation_name = "jump"
		#State.FALL:
			#animation_name = "fall"
		#State.LANDING:
			#animation_name = "landing" + suffix
		#State.ATTACKING:
			#animation_name = "attack" + String.num_int64(attack_combo)
		#State.ROLLING:
			#animation_name = "rolling"
		#State.LADDERING:
			#animation_name = "laddering"
	#return animation_name
#
#func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	#print(anim_name + " finished")
	#if anim_name.begins_with("landing") or anim_name.begins_with("rolling"):
		#action_lock = false
#
	#if anim_name.begins_with("attack") and next_state != State.ATTACKING:
		#action_lock = false
		#$AttackComboTimer.start()
	#elif anim_name.begins_with("attack") and next_state == State.ATTACKING:
		#print("preinput attack")
		#state = next_state
		#next_state = State.INVALID
		#action_lock = true
		#attack_combo += 1
	#
	#if anim_name == "attack4":
		#attack_combo = 1
		#print("attack combo is finished")
		#
	##if next_state != State.INVALID:
		##state = next_state
		##next_state = State.INVALID
		##if state == State.ATTACKING:
			##print("attack continue")
			##action_lock = true
			##attack_combo += 1
#
#func _on_attack_combo_timer_timeout() -> void:
	#attack_combo = 0
