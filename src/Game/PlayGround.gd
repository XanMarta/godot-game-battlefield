extends Node2D


export (PackedScene) var player_scene


var is_running = false



func _ready():
	$AnimationPlayer.play("open")
	yield($AnimationPlayer, "animation_finished")
	
	$Actors.prepare_game()
	$Screen/GameGUI.start()
	$Screen/GameGUI/Timer.set_time(GameData.match_time)


func start_game():
	$Map.start()
	$Actors.start_game()
	is_running = true

func end_game(winner):
	if is_running:
		$Map.end()
		if winner != null:
			$Screen/GameGUI.end(winner + " WIN")
		else:
			$Screen/GameGUI.end()
		is_running = false

func quit_game():
	get_tree().quit()

func time_out():
	is_running = false
