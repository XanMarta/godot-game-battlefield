extends KinematicBody2D


var velocity = Vector2.ZERO
var gravity_fix = 0.5


func _ready():
	velocity.y = -150.0
	$LifeTimer.start()


func _physics_process(delta):
	velocity.x = 0.0
	velocity.y += GameData.gravity * delta * gravity_fix
	velocity = move_and_slide(velocity)



func show_name():
	$Label.visible = true

func hide_name():
	$Label.visible = false



func take_gun() -> Node2D:
	var gun = $Bubble/Gun.get_child(0)
	$Bubble/Gun.remove_child(gun)
	$Bubble/BulletBar.visible = false
	$AnimationPlayer.play("disappear")
	disappear()
	return gun


func set_gun(gun):
	$Bubble/Gun.add_child(gun)
	$Bubble/BulletBar.max_value = gun.capacity
	$Bubble/BulletBar.value = gun.bullet
	$Label.text = gun.gun_name


func disappear():
	$PlayerDetect.monitorable = false
	$Label.visible = false


func _on_LifeTimer_timeout():
	$AnimationPlayer.play("flashing")
	
