extends Node2D


signal spawn_bubble(item_name, item, pos)
signal player_kill(killer, victim)
signal player_suicide(player)

# ########################

var player = []

var player_speed = Vector2(200, 350)
var gravity = 1000
var max_fall = 900
var jump_power = 2
var recoil_force = 5.0
var player_health = 100
var player_init_life = 2

var match_time = 60

var keep_gun_after_death = false

# ########################



# ########################

func _ready():
	randomize()



func random(from, to) -> int:
	return randi() % (to - from + 1) + from
