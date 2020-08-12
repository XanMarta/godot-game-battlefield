extends Node2D


export (PackedScene) var player_scene


func init_player():
	GameData.player[0] = {
		"player_name" : "Mark",
		"body" : "Blue",
		"control_type" : "p1",
		"init_gun_1" : "SM01",
		"init_gun_2" : "SR01"
	}
	GameData.player[1] = {
		"player_name" : "Daniel",
		"body" : "Red",
		"control_type" : "p2",
		"init_gun_1" : "AR01",
		"init_gun_2" : "SR01"
	}
	GameData.player[3] = {
		"player_name" : "Markus",
		"body" : "Red",
		"control_type" : "p2",
		"init_gun_1" : "SR01",
		"init_gun_2" : "SR01"
	}


func _ready():
	init_player()
	prepare_game()




func prepare_game():
	
	$Actors.prepare_game()
	GameData.player.clear()
	
	$GameGUI.start()






func start_game():
	$Map.start_game()
	$Actors.start_game()

func end_game():
	$Map.end_game()
	$GameGUI.end()

func quit_game():
	get_tree().quit()

