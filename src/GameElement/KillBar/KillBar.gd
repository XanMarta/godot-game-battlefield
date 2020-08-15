extends Node2D


var is_starting = true
var is_disappear_suddenly = false


func appear(text):
	$Bar/Label.text = text
	$AnimationPlayer.play("appear")
	yield($AnimationPlayer, "animation_finished")
	is_starting = false
	if is_disappear_suddenly:
		disappear()
	else:
		$Timer.start()


func disappear():
	$Timer.stop()
	$AnimationPlayer.play("disappear")


func disappear_suddenly():
	if is_starting:
		is_disappear_suddenly = true
	else:
		disappear()
