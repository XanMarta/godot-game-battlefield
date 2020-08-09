extends Node2D


export (PackedScene) var gun_scene

var gun_directory = "res://Assets/Gunlist/"
var gun_texture = {}    # Texture of gun
var gunlist = []        # List of gun_code
var gun = {}            # Info of gun



func load_gunlist():
	
	gunlist = [
		# Assault riffe
		"AR01",
		# Sniper riffe
		"SR01",
		# SMG
		"SM01"
	]
	
	gun["AR01"] = {
		"code": "AR01",
		"name": "Assault Riffe",
		"recoil": 200,
		"damage": 1000,
		"fire_wait": 0.15,
		"capacity": 100
	}
	
	gun["SR01"] = {
		"code": "SR01",
		"name": "Sniper Riffe",
		"recoil": 5000,
		"damage": 20000,
		"fire_wait": 1.5,
		"capacity": 10
	}
	
	gun["SM01"] = {
		"code": "SM01",
		"name": "SMG",
		"recoil": 100,
		"damage": 500,
		"fire_wait": 0.05,
		"capacity": 200
	}




func _ready():
	load_gunlist()
	for gun_code in gunlist:
		gun_texture[gun_code] = load(gun_directory + gun_code + ".png")

func create_gun(gun_code) -> Node2D:
	var new_gun = gun_scene.instance()
	new_gun.set_gun(gun_code)
	return new_gun
	
