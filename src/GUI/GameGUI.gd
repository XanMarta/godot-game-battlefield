extends Node2D


var is_start_game = true


func start():
	$Label.text = "Start game"
	$Timer.wait_time = 3.0
	is_start_game = true
	$Timer.start()



func _on_Timer_timeout():
	if is_start_game:
		$Label.hide()
