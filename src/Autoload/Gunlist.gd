extends Node2D


var gun_directory = "res://Assets/Gunlist/"

var gunlist = {}


func _ready():
	load_gunlist()


func load_gun_image(code) -> Resource:
	return load(gun_directory + code + ".png")


func load_gunlist():
	
	gunlist["AR01"] = {
		"code": "AR01",
		"name": "assault riffe",
		"recoil": 200,
		"damage": 1000,
		"fire_wait": 0.15,
		"capacity": 100
	}
	
	gunlist["SR01"] = {
		"code": "SR01",
		"name": "sniper riffe",
		"recoil": 5000,
		"damage": 20000,
		"fire_wait": 1.5,
		"capacity": 10
	}
	
	gunlist["SM01"] = {
		"code": "SM01",
		"name": "Smg",
		"recoil": 100,
		"damage": 500,
		"fire_wait": 0.05,
		"capacity": 200
	}
