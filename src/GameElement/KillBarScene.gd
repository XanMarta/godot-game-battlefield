extends Node2D

export (PackedScene) var killbar


func _ready():
	GameData.connect("player_kill", self, "player_kill")
	GameData.connect("player_suicide", self, "player_suicide")


func player_kill(killer, victim):
	spawn_bar(killer + " kill " + victim)

func player_suicide(player):
	spawn_bar(player + " commit suicide")


func spawn_bar(text):
	if $Bar.get_child_count() > 0:
		$Bar.get_child($Bar.get_child_count() - 1).disappear_suddenly()
	var spawn_pos = $SpawnBar.position
	var new_bar = killbar.instance()
	new_bar.position = spawn_pos
	$Bar.add_child(new_bar)
	new_bar.appear(text)



