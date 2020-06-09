extends KinematicBody2D


export var velocity = Vector2(500, 0)

var is_running = false



func fire(direction : float):
	velocity.x *= direction
	if direction < 0:
		$bullet.flip_h = true
	is_running = true



func _physics_process(delta):
	if is_running:
		move_and_slide(velocity)


func _on_Block_detect_body_entered(body):
	queue_free()
