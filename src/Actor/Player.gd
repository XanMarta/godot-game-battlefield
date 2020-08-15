extends Node2D

signal update_gui
signal player_die


export (PackedScene) var gun



var player_name = "Mark"
var body = "Blue"
var control_type = "p1"
var init_gun_1 = "AR01"
var init_gun_2 = "SR01"


var is_alive = false
var health = 100 setget set_health
var life = 2 setget set_life
var current_bubble = null
var current_player_shot = null



onready var player = $Player
onready var gun_hand = $Player/GunPosition/Gun_hand
onready var gun_second = $Player/GunPosition/Gun_second


func init_player():
	$Player/sprite.texture = load("res://Assets/Player/Body/" + body + ".png")
	$Player.control_type = self.control_type
	if init_gun_1 != "":
		var new_gun = Gunlist.create_gun(init_gun_1)
		gun_hand.add_child(new_gun)
	if init_gun_2 != "":
		var new_gun = Gunlist.create_gun(init_gun_2)
		gun_second.add_child(new_gun)
	self.life = GameData.player_init_life
	set_spawn_position()


func _physics_process(delta):
	if is_alive:
		$Player.move_control()
		if Input.is_action_pressed(control_type + "_fire"):
			fire()
		if Input.is_action_just_pressed(control_type + "_change"):
			change()
		if Input.is_action_just_pressed(control_type + "_drop"):
			drop()


func fire():
	if gun_hand.get_child_count() > 0:
		var gun = gun_hand.get_child(0)
		if gun.fire():
			var bullet = gun.get_bullet().instance()
			$BulletFire.add_child(bullet)
			bullet.global_position = gun.get_node("Fire_position").global_position
			bullet.fire($Player.direct, gun.damage)
			bullet.player_fire = self
			# Recoil
			$Player.force += Vector2(-gun.recoil * $Player.direct, 0)
			emit_signal("update_gui")


func change(): # and equip gun from bubble
	if current_bubble == null:
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
	
	else:
		if current_bubble.bubble_type == "gun":
			var to_target = gun_hand
			if gun_hand.get_child_count() > 0:
				if gun_second.get_child_count() == 0:
					to_target = gun_second
				else:
					drop()
			var new_gun = current_bubble.take_bubble()
			to_target.add_child(new_gun)
			player.turn_gun()
	
	emit_signal("update_gui")


func drop():
	if gun_hand.get_child_count() > 0:
		var old_gun = gun_hand.get_child(0)
		old_gun.get_node("sprite").flip_v = false
		var old_position = old_gun.global_position
		gun_hand.remove_child(old_gun)
		GameData.emit_signal("spawn_bubble", "gun", old_gun, old_position)
		emit_signal("update_gui")


func drop_all():
	if gun_hand.get_child_count() > 0:
		var old_gun = gun_hand.get_child(0)
		old_gun.get_node("sprite").flip_v = false
		var old_position = old_gun.global_position + Vector2(30, 0)
		gun_hand.remove_child(old_gun)
		GameData.emit_signal("spawn_bubble", "gun", old_gun, old_position)
	if gun_second.get_child_count() > 0:
		var old_gun = gun_second.get_child(0)
		old_gun.get_node("sprite").flip_v = false
		var old_position = old_gun.global_position - Vector2(30, 0)
		gun_second.remove_child(old_gun)
		GameData.emit_signal("spawn_bubble", "gun", old_gun, old_position)
	emit_signal("update_gui")



func spawn():
	$Player.velocity = Vector2.ZERO
	$Player.jump = GameData.jump_power
	$Player.turn(true)
	$Player.force = Vector2.ZERO
	is_alive = true
	self.health = 100
	$AnimationPlayer.play("spawn")
	$Player/HealthBar.visible = false
	$Player/BulletDetect.set_deferred("monitoring", true)
	emit_signal("update_gui")


func take_bullet(bullet):
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
	current_player_shot = bullet.player_fire
	$Timer/Player_shot.start()


func die():
	is_alive = false
	self.life -= 1
	print("dead. Remain life: ", life)
	emit_signal("update_gui")
	$AnimationPlayer.play("dead")
	if current_player_shot != null:
		GameData.emit_signal("player_kill", current_player_shot.player_name, player_name)
	else:
		GameData.emit_signal("player_suicide", player_name)
	call_deferred("drop_all")
	$Player/BulletDetect.set_deferred("monitoring", false)
	yield($AnimationPlayer, "animation_finished")
	set_spawn_position()
	if life > 0:
		spawn()
	else:
		emit_signal("player_die")


func set_health(value):
	health = value
	$Player/HealthBar.value = health
	emit_signal("update_gui")

func set_life(value):
	life = value
	emit_signal("update_gui")


func set_spawn_position():
	$SpawnPath/PathFollow2D.unit_offset = randf()
	$Player.global_position = $SpawnPath/PathFollow2D.global_position



func touch_deadzone(body):
	die()


func bubble_entered(bubble):
	# When bubble is gun
	if bubble.get_parent().bubble_type == "gun":
		if current_bubble != null:
			current_bubble.hide_name()
		current_bubble = bubble.get_parent()
		current_bubble.show_name()
	# When bubble is not gun
	else:
		var new_bubble = bubble.get_parent()
		
		# Heart
		if new_bubble.bubble_type == "heart":
			self.life += 1
		# Bullet_box
		elif new_bubble.bubble_type == "bullet_box":
			if gun_hand.get_child_count() > 0:
				gun_hand.get_child(0).fill(false)
			if gun_second.get_child_count() > 0:
				gun_second.get_child(0).fill(false)
			emit_signal("update_gui")
		# Splash
		elif new_bubble.bubble_type == "splash":
			$Player.boost_speed()
		
		new_bubble.take_bubble()


func bubble_exited(bubble):
	if current_bubble == bubble.get_parent():
		current_bubble.hide_name()
		current_bubble = null


func reset_player_shot():
	current_player_shot = null

