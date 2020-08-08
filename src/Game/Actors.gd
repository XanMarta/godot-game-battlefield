extends Node2D



func prepare_game():
	# Init player
	for player in get_children():
		player.init_player()
	# Connect player
	var current = 0
	for new_player in get_children():
		get_parent().get_node("Player_tag_scene").player[current] = new_player
		current += 1
		if current > 3:
			break
	get_parent().get_node("Player_tag_scene").connect_player()


func start_game():
	for player in get_children():
		player.spawn()
