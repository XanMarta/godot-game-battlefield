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
			$Gunhand/gun.texture = gun_slot.get_node("Gun_hand").get_child(0).get_node("sprite").texture
		else:
			$Gunhand/gun.texture = null
		if gun_slot.get_node("Gun_second").get_child_count() > 0:
			$Gunsecond/gun.texture = gun_slot.get_node("Gun_second").get_child(0).get_node("sprite").texture
		else:
			$Gunsecond/gun.texture = null
		
		$HealthBar.value = target.health
