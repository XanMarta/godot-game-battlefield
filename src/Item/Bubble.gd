extends KinematicBody2D


export var bubble_type = ""
export var life_time = 10.0

var velocity = Vector2.ZERO
var gravity_fix = 0.5


func _ready():
	velocity.y = -150.0
	$LifeTimer.wait_time = life_time
	$LifeTimer.start()

func _physics_process(delta):
	velocity.x = 0.0
	velocity.y += GameData.gravity * delta * gravity_fix
	velocity = move_and_slide(velocity)



func set_gun(gun):
	$Bubble/Gun/Gun.add_child(gun)
	$Bubble/Gun/BulletBar.max_value = gun.capacity
	$Bubble/Gun/BulletBar.value = gun.bullet
	$Label.text = gun.gun_name
	bubble_type = "gun"
	$Bubble/Gun.visible = true


func set_item(item_name):
	$Label.text = item_name
	$Bubble/Item/image.texture = load("res://Assets/" + item_name + ".png")
	bubble_type = item_name
	$Bubble/Item.visible = true



func take_bubble() -> Node2D:
	if bubble_type == "gun":
		var gun = $Bubble/Gun/Gun.get_child(0)
		$Bubble/Gun/Gun.remove_child(gun)
		$Bubble/Gun.visible = false
		$AnimationPlayer.play("disappear")
		return gun
	else:
		$AnimationPlayer.play("disappear")
		return null
	





func show_name():
	$Label.visible = true

func hide_name():
	$Label.visible = false



func _on_LifeTimer_timeout():
	$AnimationPlayer.play("flashing")
	
