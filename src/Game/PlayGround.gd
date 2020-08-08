extends Node2D


export (PackedScene) var player_scene



func init_player():
	GameData.player.push_back({
		"player_name" : "Mark",
		"body" : "Blue",
		"control_type" : "p1",
		"init_gun_1" : "SM01",
		"init_gun_2" : "SR01"
	})
	GameData.player.push_back({
		"player_name" : "Daniel",
		"body" : "Red",
		"control_type" : "p2",
		"init_gun_1" : "AR01",
		"init_gun_2" : "SR01"
	})


func _ready():
	init_player()
	prepare_game()



func prepare_game():
	# Import player
	for player in GameData.player:
		var new_player = player_scene.instance()
		new_player.player_name = player["player_name"]
		new_player.body = player["body"]
		new_player.control_type = player["control_type"]
		new_player.init_gun_1 = player["init_gun_1"]
		new_player.init_gun_2 = player["init_gun_2"]
		$Actors.add_child(new_player)
	$Actors.prepare_game()
	GameData.player.clear()
	
	$GameGUI.start()



func _on_GameGUI_start_game():
	start_game()


func start_game():
	$Map.start_game()
	$Actors.start_game()



