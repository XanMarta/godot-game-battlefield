extends Area2D



func _on_body_entered(body):
	$Label.visible = true


func _on_body_exited(body):
	$Label.visible = false


func take_gun() -> Node2D:
	var gun = $Bubble/Gun.get_child(0)
	$Bubble/Gun.remove_child(gun)
	$Bubble/BulletBar.visible = false
	$AnimationPlayer.play("disappear")
	monitorable = false
	return gun


func set_gun(gun):
	$Bubble/Gun.add_child(gun)
	$Bubble/BulletBar.max_value = gun.capacity
	$Bubble/BulletBar.value = gun.bullet


