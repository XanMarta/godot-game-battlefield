extends Node2D


var map_size = Vector2(31, 18)
var ground = []


func _ready():
	var map = $Map.get_child(0).get_node("Block")
	for x in range(map_size.x):
		for y in range(map_size.y):
			if map.get_cell(x, y) >= 0:
				ground.push_back({"x": x, "y": y})



func start_game():
	$ItemSpawn.start()

func end_game():
	$ItemSpawn.stop()



func spawn_item(item_name):
	var map = $Map.get_child(0).get_node("Block")
	var ran = rand_range(0, ground.size() - 1)
	var spawn_cell = Vector2(ground[ran]["x"], ground[ran]["y"] - 1)
	var spawn_position = map.map_to_world(spawn_cell)
	if item_name != "gun":
		GameData.emit_signal("spawn_bubble", item_name, null, spawn_position)
	else:
		GameData.emit_signal("spawn_bubble", item_name, get_random_gun(), spawn_position)



func _on_ItemSpawn_timeout():
	var spawn_choice = rand_range(0.0, 5.0)
	if spawn_choice >= 1.0 and spawn_choice < 2.0:
		spawn_item("heart")
	elif spawn_choice >= 2.0 and spawn_choice < 3.0:
		spawn_item("bullet_box")
	elif spawn_choice >= 3.0 and spawn_choice < 4.0:
		spawn_item("splash")
	elif spawn_choice >= 4.0 and spawn_choice < 5.0:
		spawn_item("gun")


func get_random_gun() -> Node2D:
	var ran = rand_range(0, Gunlist.gunlist.size() - 1)
	return Gunlist.create_gun(Gunlist.gunlist[ran])
