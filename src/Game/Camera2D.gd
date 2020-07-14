extends Camera2D


func _physics_process(delta):
	pass
	var num_player = 0
	var new_pos = Vector2.ZERO
	for child in get_parent().get_node("Actors").get_children():
		if child.is_alive:
			new_pos += child.get_node("Player").global_position
			num_player += 1
	if num_player == 0:
		num_player = 1
	new_pos /= num_player
	position = new_pos
