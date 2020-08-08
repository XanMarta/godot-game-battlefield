extends Node2D

signal start_game


var is_start_game = true


func start():
	$Label.show()
	$Label.text = "READY"
	yield(get_tree().create_timer(2.0), "timeout")
	$Label.hide()
	yield(get_tree().create_timer(1.0), "timeout")
	$Label.show()
	$Label.text = "START"
	emit_signal("start_game")
	yield(get_tree().create_timer(2.0), "timeout")
	$Label.hide()

