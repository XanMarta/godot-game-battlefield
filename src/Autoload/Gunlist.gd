extends Node2D


export (PackedScene) var gun_scene


var gunlist = []        # List of gun_code
var gun = {}            # Info of gun



func load_gunlist():
	
	gunlist = [
		# Assault riffe
		"AR01",
		# Sniper riffe
		"SR01",
		# SMG
		"SM01",
		# Piston
		"PT01"
	]
	
	gun["AR01"] = {
		"code": "AR01",
		"name": "Assault Riffe",
		"recoil": 200,
		"damage": 1000,
		"firerate": 7,
		"capacity": 100
	}
	
	gun["SR01"] = {
		"code": "SR01",
		"name": "Sniper Riffe",
		"recoil": 5000,
		"damage": 20000,
		"firerate": 0.6,
		"capacity": 10
	}
	
	gun["SM01"] = {
		"code": "SM01",
		"name": "SMG",
		"recoil": 100,
		"damage": 500,
		"firerate": 20,
		"capacity": 200
	}
	
	gun["PT01"] = {
		"code": "PT01",
		"name": "Piston",
		"recoil": 80,
		"damage": 800,
		"firerate": 4,
		"capacity": 50
	}




func _ready():
	load_gunlist()


func create_gun(gun_code) -> Node2D:
	var new_gun = gun_scene.instance()
	new_gun.set_gun(gun_code)
	return new_gun
	
