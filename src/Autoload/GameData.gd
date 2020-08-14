extends Node2D


signal spawn_bubble(item_name, item, pos)

# Detached data ########################

var player_speed = Vector2(200, 350)
var gravity = 1000
var max_fall = 900
var jump_power = 2
var recoil_force = 5.0
var player_health = 100
var player_init_life = 1


# Imported data ########################

var player = []




func _ready():
	randomize()



func random(from, to) -> int:
	return randi() % (to - from + 1) + from
