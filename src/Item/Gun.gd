extends Node2D


export (PackedScene) var bullet_type
export var gun_name = "Gun"
export var recoil = 200
export var damage = 1000
export var firerate = 7


var velocity = Vector2.ZERO
var is_firing = true
var capacity = 100
var bullet = 100


func set_gun(gun_code): # Spawn new gun by gun_code
	var gun = Gunlist.gun[gun_code]
	$sprite.texture = DataList.gun_texture[gun_code]
	gun_name = gun["name"]
	recoil = gun["recoil"]
	damage = gun["damage"]
	firerate = gun["firerate"]
	capacity = gun["capacity"]
	bullet = capacity
	$Fire_rate.wait_time = 1.0 / firerate


func fill(all = true):
	if all:
		bullet = capacity
	else:
		bullet += capacity / 2
		bullet = clamp(bullet, 0, capacity)


func get_bullet() -> PackedScene:
	return bullet_type


func fire() -> bool:
	if bullet == 0:
		return false
	if is_firing:
		is_firing = false
		bullet -= 1
		$Fire_rate.start()
		$AnimationPlayer.stop()
		$AnimationPlayer.play("fire")
		return true
	return is_firing


func _on_Fire_rate_timeout():
	is_firing = true
