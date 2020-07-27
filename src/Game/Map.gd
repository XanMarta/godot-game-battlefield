extends Node2D


var map_size = Vector2(31, 18)

var temp = 1

func _ready():
	$ItemSpawn.start()



func spawn_item(item_name):
	var map = $Map.get_child(0).get_node("Block")
	while true:
		var spawn_cell = Vector2.ZERO
		spawn_cell.x = rand_range(0, map_size.x)
		spawn_cell.y = rand_range(0, map_size.y)
		if map.get_cell(spawn_cell.x, spawn_cell.y) >= 0:
			spawn_cell.y -= 1
			var spawn_position = map.map_to_world(spawn_cell)
			GameData.emit_signal("spawn_bubble", item_name, null, spawn_position)
			break
			


func _on_ItemSpawn_timeout():
	if temp == 1:
		spawn_item("heart")
	elif temp == 2:
		spawn_item("bullet_box")
	elif temp == 3:
		spawn_item("splash")
	
	temp += 1
	if temp == 4:
		temp = 1
