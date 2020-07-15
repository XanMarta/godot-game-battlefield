extends KinematicBody2D



var velocity = Vector2.ZERO
var jump
var direct = 1.0
var force = Vector2(0, 0)
var type


func move_control():
	var direction = Input.get_action_strength(type + "_right") - Input.get_action_strength(type + "_left")
	if direction < 0.0:
		turn(false)
	elif direction > 0.0:
		turn(true)
	
	velocity.x = direction * GameData.player_speed.x
	velocity.y += GameData.gravity * get_physics_process_delta_time()
	
	if is_on_floor():
		jump = GameData.jump_power
	
	if Input.is_action_just_pressed(type + "_up"):
		if jump > 0:
			jump -= 1
			velocity.y = -GameData.player_speed.y
			get_parent().get_node("smoke_jump").global_position = global_position
			get_parent().get_node("AnimationPlayer").stop(true)
			get_parent().get_node("AnimationPlayer").play("jump")
	
	# Calculate force
	var add_force = force / GameData.recoil_force
	force -= add_force
	velocity += add_force
	
	velocity.y = clamp(velocity.y, -GameData.max_fall, GameData.max_fall)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed(type + "_down"):
		if is_on_floor():
			set_collision_mask_bit(1, false)
			velocity.y += GameData.gravity * get_physics_process_delta_time()
			yield(get_tree().create_timer(0.2), "timeout")
			set_collision_mask_bit(1, true)


func turn(right : bool):
	if right:
		$sprite.flip_h = false
		$GunPosition.rotation = 0
		$GunPosition/Gun_second.rotation = -PI / 2
		direct = 1.0
	else:
		$sprite.flip_h = true
		$GunPosition.rotation = PI
		$GunPosition/Gun_second.rotation = PI / 2
		direct = -1.0
		
	if $GunPosition/Gun_hand.get_child_count() > 0:
		$GunPosition/Gun_hand.get_child(0).get_node("sprite").flip_v = true if direct == -1.0 else false
	if $GunPosition/Gun_second.get_child_count() > 0:
		$GunPosition/Gun_second.get_child(0).get_node("sprite").flip_v = true if direct == -1.0 else false
