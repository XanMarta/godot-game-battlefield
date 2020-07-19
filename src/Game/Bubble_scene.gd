extends Node2D


var bubble = load("res://src/Item/Bubble.tscn")


func _ready():
	GameData.connect("drop_gun", self, "spawn_bubble")



func spawn_bubble(gun, pos):
	var new_bubble = bubble.instance()
	new_bubble.set_gun(gun)
	new_bubble.position = pos
	add_child(new_bubble)

