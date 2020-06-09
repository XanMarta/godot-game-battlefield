extends Node2D

export (PackedScene) var bullet
export var recoil = 50


var velocity = Vector2.ZERO
var is_firing = true



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
