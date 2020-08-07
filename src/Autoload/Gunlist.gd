extends Node2D


var gunlist = {}


func _ready():
	load_gunlist()


func load_gunlist():
	
	gunlist["AR01"] = {
		"name": "assault riffe",
		"image": load("res://Assets/gun1.png"),
		"recoil": 200,
		"damage": 1000,
		"fire_wait": 0.15,
		"capacity": 100
	}
	
	gunlist["SR01"] = {
		"name": "sniper riffe",
		"image": load("res://Assets/gun2.png"),
		"recoil": 5000,
		"damage": 20000,
		"fire_wait": 1.5,
		"capacity": 10
	}
	
	gunlist["SM01"] = {
		"name": "Smg",
		"image": load("res://Assets/gun1.png"),
		"recoil": 100,
		"damage": 500,
		"fire_wait": 0.05,
		"capacity": 200
	}
