extends Node2D

signal update_gui


export var speed = Vector2(200, 350)
export var gravity = 1000
export var max_fall = 900
export var jump_power = 2
export var type = "p1"
export var recoil_force = 5.0
export var player_name = "Mark"
export (PackedScene) var gun

export var health = 100 setget set_health


var velocity = Vector2.ZERO
var jump = jump_power
var direct = 1.0
var force = Vector2(0, 0)
var is_alive = false

onready var player = $Player
onready var gun_hand = $Player/GunPosition/Gun_hand
onready var gun_second = $Player/GunPosition/Gun_second


func _ready():
	$Player/sprite.texture = load("res://Assets/" + type + ".png")
	spawn()
	equip_gun(GameData.assault, true)
	equip_gun(GameData.sniper, false)

func _physics_process(delta):
	if is_alive:
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
		turn(false)
	elif direction > 0.0:
		turn(true)
	
	velocity.x = direction * speed.x
	velocity.y += gravity * get_physics_process_delta_time()
	
	if player.is_on_floor():
		jump = jump_power
	
	if Input.is_action_just_pressed(type + "_up"):
		if jump > 0:
			jump -= 1
			velocity.y = -speed.y
			$smoke_jump.global_position = player.global_position
			$AnimationPlayer.stop(true)
			$AnimationPlayer.play("jump")
	
	# Calculate force
	var add_force = force / recoil_force
	force -= add_force
	velocity += add_force
	
	velocity.y = clamp(velocity.y, -max_fall, max_fall)
	velocity = player.move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_just_pressed(type + "_down"):
		if player.is_on_floor():
			player.set_collision_mask_bit(1, false)
			velocity.y += gravity * get_physics_process_delta_time()
			yield(get_tree().create_timer(0.2), "timeout")
			player.set_collision_mask_bit(1, true)


func turn(right : bool):
	if right:
		$Player/sprite.flip_h = false
		$Player/GunPosition.rotation = 0
		gun_second.rotation = -PI / 2
		direct = 1.0
	else:
		$Player/sprite.flip_h = true
		$Player/GunPosition.rotation = PI
		gun_second.rotation = PI / 2
		direct = -1.0
		
	if gun_hand.get_child_count() > 0:
		gun_hand.get_child(0).get_node("sprite").flip_v = true if direct == -1.0 else false
	if gun_second.get_child_count() > 0:
		gun_second.get_child(0).get_node("sprite").flip_v = true if direct == -1.0 else false


func fire():
	if gun_hand.get_child_count() > 0:
		var gun = gun_hand.get_child(0)
		if gun.fire():
			var bullet = gun.get_bullet().instance()
			add_child(bullet)
			bullet.global_position = gun.get_node("Fire_position").global_position
			bullet.fire(direct, gun.damage)
			# Recoil
			force += Vector2(-gun.recoil * direct, 0)

func change():
	var old_gun_hand = null
	var old_gun_second = null
	if gun_hand.get_child_count() > 0:
		old_gun_hand = gun_hand.get_child(0)
		gun_hand.remove_child(old_gun_hand)
	if gun_second.get_child_count() > 0:
		old_gun_second = gun_second.get_child(0)
		gun_second.remove_child(old_gun_second)
	if old_gun_hand != null:
		gun_second.add_child(old_gun_hand)
	if old_gun_second != null:
		gun_hand.add_child(old_gun_second)
	emit_signal("update_gui")

func drop():
	if gun_hand.get_child_count() > 0:
		gun_hand.get_child(0).queue_free()
	emit_signal("update_gui")


func spawn():
	$SpawnPath/PathFollow2D.unit_offset = randf()
	$Player.global_position = $SpawnPath/PathFollow2D.global_position
	velocity = Vector2.ZERO
	jump = jump_power
	turn(true)
	force = Vector2.ZERO
	is_alive = true
	self.health = 100
	$AnimationPlayer.play("spawn")
	$Player/HealthBar.visible = false

func equip_gun(gun_type, to_hand = true):
	var to_target = gun_hand if to_hand else gun_second
	if to_target.get_child_count() == 0:
		var new_gun = gun.instance()
		new_gun.set_gun(gun_type)
		to_target.add_child(new_gun)


func _on_BulletDetect_body_entered(bullet):
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("hurt")
	force += Vector2(bullet.damage * bullet.direction, 0)
	self.health -= bullet.damage / 1000
	print("health: ", health)
	bullet.queue_free()
	$Player/HealthBar.visible = true
	if health <= 0.0:
		die()


func die():
	print("dead")
	is_alive = false
	$AnimationPlayer.play("dead")
	$Player/BulletDetect.set_deferred("monitoring", false)
	yield($AnimationPlayer, "animation_finished")
	$Player/BulletDetect.set_deferred("monitoring", true)
	spawn()


func set_health(value):
	health = value
	$Player/HealthBar.value = health

func _on_DeadzoneDetect_body_entered(body):
	die()
