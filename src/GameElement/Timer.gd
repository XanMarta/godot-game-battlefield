extends Node2D

signal time_out



var current_time = 100 setget update_time


func set_time(second):
	$Timer_ray.max_value = second
	self.current_time = second


func start():
	$Timer.start()
	$Clock.show()


func update_time(value):
	current_time = value
	var minute = current_time / 60
	var second = current_time - minute * 60
	var text = ""
	text = text + str(minute) if minute >= 10 else text + "0" + str(minute)
	text += ":"
	text = text + str(second) if second >= 10 else text + "0" + str(second)
	$Clock.text = text
	$Timer_ray.value = value
	
	if current_time == 0:
		$Timer.stop()
		emit_signal("time_out")


func _on_Timer_timeout():
	self.current_time -= 1
