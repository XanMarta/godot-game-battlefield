extends Node2D



func connect_player(player, stack):
	if stack >= 0 and stack <= 3:
		get_node("Player" + str(stack)).connect_player(player)
