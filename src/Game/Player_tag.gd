extends Node2D


func _ready():
	$Player1.connect_player(get_parent().get_node("Actors/Player1"))
	$Player2.connect_player(get_parent().get_node("Actors/Player2"))


func _physics_process(delta):
	global_position = get_parent().get_node("Camera/Camera2D").get_camera_screen_center()
