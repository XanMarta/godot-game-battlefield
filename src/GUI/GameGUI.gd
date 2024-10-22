extends Node2D

signal start_game
signal quit_game
signal time_out


var is_start_game = true


func start():
	$Label.show()
	$Label.text = "READY"
	yield(get_tree().create_timer(2.0), "timeout")
	$Label.hide()
	yield(get_tree().create_timer(1.0), "timeout")
	$Label.show()
	$Label.text = "START"
	$Timer.start()
	emit_signal("start_game")
	yield(get_tree().create_timer(2.0), "timeout")
	$Label.hide()



func end(text = "END GAME"):
	$Label.show()
	$Label.text = text
	yield(get_tree().create_timer(3.0), "timeout")
	$Label.hide()
	emit_signal("quit_game")

func time_out():
	emit_signal("time_out")
	end("TIME OUT")
