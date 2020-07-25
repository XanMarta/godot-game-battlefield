extends Node2D



var player = [null, null, null, null]


func _ready():
	position.y = -get_viewport().size.y


func connect_player():
	for current in range(4):
		if player[current] != null:
			get_node("Player" + str(current)).connect_player(player[current])
			
