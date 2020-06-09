extends Node2D


export var speed = Vector2(200, 350)
export var gravity = 1000
export var jump_power = 2
export var type = "p1"


onready var player = $Player
var velocity = Vector2.ZERO
var jump = jump_power
var direct = 1.0


func _ready():
	$Player/sprite.texture = load("res://Assets/" + type + ".png")


func _physics_process(delta):
	move_control()
	if Input.is_action_pressed(type + "_fire"):
		fire()
	if Input.is_action_just_pressed(type + "_change"):
		change()
	if Input.is_action_just_pressed(type + "_drop"):
		drop()



func move_control():
	var direction = Input.get_action_strength(type + "_right") - Input.get_action_strength(type + "_left")
	if direction < 0.0:
		$Player/sprite.flip_h = true
		$Player/GunPosition.rotation = PI
		$Player/GunPosition/Gun_second.rotation = PI / 2
		direct = -1.0
	elif direction > 0.0:
		$Player/sprite.flip_h = false
		$Player/GunPosition.rotation = 0
		$Player/GunPosition/Gun_second.rotation = -PI / 2
		direct = 1.0
	
	velocity.x = direction * speed.x
	velocity.y += gravity * get_physics_process_delta_time()
	
	if player.is_on_floor():
		jump = jump_power
	
	if Input.is_action_just_pressed(type + "_up"):
		if jump > 0:
			jump -= 1
			velocity.y = -speed.y
			$smoke_jump.global_position = player.global_position
			$AnimationPlayer.stop()
			$AnimationPlayer.play("jump")
	
	velocity = player.move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed(type + "_down"):
		if player.is_on_floor():
			player.set_collision_mask_bit(1, false)
			velocity.y += gravity * get_physics_process_delta_time()
			yield(get_tree().create_timer(0.2), "timeout")
			player.set_collision_mask_bit(1, true)


func fire():
	if $Player/GunPosition/Gun_hand.get_child_count() > 0:
		var gun = $Player/GunPosition/Gun_hand.get_child(0)
		if gun.fire():
			var bullet = gun.get_bullet().instance()
			add_child(bullet)
			bullet.global_position = gun.get_node("Fire_position").global_position
			bullet.fire(direct)

func change():
	var gun_hand = null
	var gun_second = null
	if $Player/GunPosition/Gun_hand.get_child_count() > 0:
		gun_hand = $Player/GunPosition/Gun_hand.get_child(0)
		$Player/GunPosition/Gun_hand.remove_child(gun_hand)
	if $Player/GunPosition/Gun_second.get_child_count() > 0:
		gun_second = $Player/GunPosition/Gun_second.get_child(0)
		$Player/GunPosition/Gun_second.remove_child(gun_second)
	if gun_hand != null:
		$Player/GunPosition/Gun_second.add_child(gun_hand)
	if gun_second != null:
		$Player/GunPosition/Gun_hand.add_child(gun_second)

func drop():
	if $Player/GunPosition/Gun_hand.get_child_count() > 0:
		$Player/GunPosition/Gun_hand.get_child(0).queue_free()
