extends Node2D



var body_directory = "res://Assets/Player/Body/"
var hat_directory = ""
var gun_directory = "res://Assets/Gunlist/"

var body_list = []
var hat_list = []

var body_texture = {}
var hat_texture = {}
var gun_texture = {}



func load_list():
	body_list = [
		"Blue", "Red"
	]


func load_texture():
	for code in body_list:
		body_texture[code] = load(body_directory + code + ".png")
	
	for code in Gunlist.gunlist:
		gun_texture[code] = load(gun_directory + code + ".png")


func _ready():
	load_list()
	load_texture()
