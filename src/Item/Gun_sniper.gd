extends Node2D


export (PackedScene) var bullet
export var recoil = 5000
export var damage = 20000
export var fire_wait = 1.5


var velocity = Vector2.ZERO
var is_firing = true

func _ready():
	$Fire_rate.wait_time = fire_wait


func get_bullet() -> PackedScene:
	return bullet


func fire() -> bool:
	if is_firing:
		is_firing = false
		$Fire_rate.start()
		return true
	return is_firing


func _on_Fire_rate_timeout():
	is_firing = true
