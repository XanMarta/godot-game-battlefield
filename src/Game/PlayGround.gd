extends Node2D


export (PackedScene) var player_scene


var is_running = false
var timing = 15


func init_player():
	GameData.player = [null, null, null, null]
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
		"control_type" : "p3",
		"init_gun_1" : "SR01",
		"init_gun_2" : "SR01"
	}


func _ready():
	init_player()
	prepare_game()


func prepare_game():
	$Actors.prepare_game()
	$Screen/GameGUI.start()
	$Screen/GameGUI/Timer.set_time(timing)


func start_game():
	$Map.start_game()
	$Actors.start_game()
	is_running = true

func end_game(winner):
	if is_running:
		$Map.end_game()
		if winner != null:
			$Screen/GameGUI.end(winner + " WIN")
		else:
			$Screen/GameGUI.end()
		is_running = false

func quit_game():
	get_tree().quit()

func time_out():
	is_running = false
