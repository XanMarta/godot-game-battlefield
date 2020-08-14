extends Node2D

signal end_game(winner)


export (PackedScene) var player_scene
var remain_player = 0


func prepare_game():
	var player_tag = get_parent().get_node("Screen/Player_tag_scene")
	# Import player
	for stack in GameData.player.size():
		var player = GameData.player[stack]
		if player != null:
			var new_player = player_scene.instance()
			new_player.player_name = player["player_name"]
			new_player.body = player["body"]
			new_player.control_type = player["control_type"]
			new_player.init_gun_1 = player["init_gun_1"]
			new_player.init_gun_2 = player["init_gun_2"]
			new_player.connect("player_die", self, "player_die")
			add_child(new_player)
			new_player.init_player()
			player_tag.connect_player(new_player, stack)
			remain_player += 1
	



func start_game():
	for player in get_children():
		player.spawn()


func player_die():
	remain_player -= 1
	if remain_player <= 1:
		for player in get_children():
			if player.is_alive:
				emit_signal("end_game", player.player_name)
				return
		emit_signal("end_game", null)
