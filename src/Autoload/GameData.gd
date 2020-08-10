extends Node2D


signal spawn_bubble(item_name, item, pos)

# Detached data ########################

var player_speed = Vector2(200, 350)
var gravity = 1000
var max_fall = 900
var jump_power = 2
var recoil_force = 5.0
var player_health = 100


# Imported data ########################

var player = []

var player_life = 2

#var player = {
#	"player_name" : "Mark",
#	"body" : "p1",
#	"control_type" : "p1",
#	"init_gun_1" : "AR01",
#	"init_gun_2" : "SR01"
#}


func _ready():
	randomize()
