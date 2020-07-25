extends Node2D



func _ready():
	var current = 0
	for new_player in get_children():
		get_parent().get_node("Player_tag_scene").player[current] = new_player
		current += 1
		if current > 3:
			break
	
	get_parent().get_node("Player_tag_scene").connect_player()
