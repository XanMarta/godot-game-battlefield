extends Node2D

export (PackedScene) var playground


func _ready():
	for panel in $Panel.get_children():
		panel.connect("freeze", self, "freeze")
		panel.connect("unfreeze", self, "unfreeze")


func freeze():
	for panel in $Panel.get_children():
		panel.freeze()
	$Black_screen.show()
	$FightButton.hide()

func unfreeze():
	for panel in $Panel.get_children():
		panel.unfreeze()
	$Black_screen.hide()
	$FightButton.show()


func FightButton_pressed():
	print("Fight")
	fight()



func fight():
	GameData.player = [null, null, null, null]
	for current in range(4):
		var player = $Panel.get_node("Player" + str(current))
		if player.has_player:
			var current_player = {}
			current_player["player_name"] = player.current_name
			current_player["body"] = player.current_body
			current_player["control_type"] = "p" + str(current + 1)
			current_player["init_gun_1"] = player.current_gun
			current_player["init_gun_2"] = ""
			
			GameData.player[current] = current_player
	
	$FightButton.hide()
	$AnimationPlayer.play("close")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene_to(playground)
