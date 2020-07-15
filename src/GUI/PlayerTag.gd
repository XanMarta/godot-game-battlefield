extends Node2D

var target = null


func connect_player(player):
	target = player
	player.connect("update_gui", self, "update_gui")
	$Name.text = player.player_name
	update_gui()


func update_gui():
	if target != null:
		$Player/player.texture = target.get_node("Player").get_node("sprite").texture
		var gun_slot = target.get_node("Player").get_node("GunPosition")
		
		if gun_slot.get_node("Gun_hand").get_child_count() > 0:
			var gun_hand = gun_slot.get_node("Gun_hand").get_child(0)
			$Gunhand/gun.texture = gun_hand.get_node("sprite").texture
			$Gunhand/Bullet.max_value = gun_hand.capacity
			$Gunhand/Bullet.value = gun_hand.bullet
			$Gunhand/Bullet.visible = true
		else:
			$Gunhand/gun.texture = null
			$Gunhand/Bullet.visible = false
		if gun_slot.get_node("Gun_second").get_child_count() > 0:
			var gun_second = gun_slot.get_node("Gun_second").get_child(0)
			$Gunsecond/gun.texture = gun_second.get_node("sprite").texture
			$Gunsecond/Bullet.max_value = gun_second.capacity
			$Gunsecond/Bullet.value = gun_second.bullet
			$Gunsecond/Bullet.visible = true
		else:
			$Gunsecond/gun.texture = null
			$Gunsecond/Bullet.visible = false
		
		$HealthBar.value = target.health
		if !target.is_alive:
			$AnimationPlayer.play("player_die")
