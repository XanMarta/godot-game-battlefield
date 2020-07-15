extends Node2D

var player_speed = Vector2(200, 350)
var gravity = 1000
var max_fall = 900
var jump_power = 2
var recoil_force = 5.0



var assault = {
	"name": "assault riffe",
	"image": load("res://Assets/gun1.png"),
	"recoil": 200,
	"damage": 1000,
	"fire_wait": 0.15
}

var sniper = {
	"name": "sniper riffe",
	"image": load("res://Assets/gun2.png"),
	"recoil": 5000,
	"damage": 20000,
	"fire_wait": 1.5
}
