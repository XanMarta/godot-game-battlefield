extends Node2D

signal update_gui


export var type = "p1"
export var player_name = "Mark"
export (PackedScene) var gun

export var health = 100 setget set_health



var is_alive = false

onready var player = $Player
onready var gun_hand = $Player/GunPosition/Gun_hand
onready var gun_second = $Player/GunPosition/Gun_second


func _ready():
	$Player/sprite.texture = load("res://Assets/" + type + ".png")
	$Player.type = self.type
	spawn()
	equip_gun(GameData.assault, true)
	equip_gun(GameData.sniper, false)


func _physics_process(delta):
	if is_alive:
		$Player.move_control()
		if Input.is_action_pressed(type + "_fire"):
			fire()
		if Input.is_action_just_pressed(type + "_change"):
			change()
		if Input.is_action_just_pressed(type + "_drop"):
			drop()


func fire():
	if gun_hand.get_child_count() > 0:
		var gun = gun_hand.get_child(0)
		if gun.fire():
			var bullet = gun.get_bullet().instance()
			add_child(bullet)
			bullet.global_position = gun.get_node("Fire_position").global_position
			bullet.fire($Player.direct, gun.damage)
			# Recoil
			$Player.force += Vector2(-gun.recoil * $Player.direct, 0)

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
	$Player.velocity = Vector2.ZERO
	$Player.jump = GameData.jump_power
	$Player.turn(true)
	$Player.force = Vector2.ZERO
	is_alive = true
	self.health = 100
	$AnimationPlayer.play("spawn")
	$Player/HealthBar.visible = false
	emit_signal("update_gui")

func equip_gun(gun_type, to_hand = true):
	var to_target = gun_hand if to_hand else gun_second
	if to_target.get_child_count() == 0:
		var new_gun = gun.instance()
		new_gun.set_gun(gun_type)
		to_target.add_child(new_gun)


func _on_BulletDetect_body_entered(bullet):
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("hurt")
	$Player.force += Vector2(bullet.damage * bullet.direction, 0)
	self.health -= bullet.damage / 1000
	print("health: ", health)
	bullet.queue_free()
	$Player/HealthBar.visible = true
	if health <= 0.0:
		die()
	emit_signal("update_gui")


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
