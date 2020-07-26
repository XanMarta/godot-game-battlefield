extends Node2D


var bubble = load("res://src/Item/Bubble.tscn")


func _ready():
	GameData.connect("spawn_bubble", self, "spawn_bubble")



func spawn_bubble(item_name, item, pos):
	var new_bubble = bubble.instance()
	new_bubble.bubble_type = item_name
	if item_name == "gun":
		new_bubble.set_gun(item)
	else:
		new_bubble.set_item(item_name)
	new_bubble.position = pos
	add_child(new_bubble)
	print("Spawn bubble: ", item_name)

