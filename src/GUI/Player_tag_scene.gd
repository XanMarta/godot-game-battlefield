extends Node2D




func _ready():
	position.y = -get_viewport().size.y


func connect_player(player, stack):
	get_node("Player" + str(stack)).connect_player(player)
