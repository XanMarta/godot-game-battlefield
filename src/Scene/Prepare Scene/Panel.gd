extends Node2D


export var direction = "left"


func _ready():
	if direction == "left":
		$Image.texture = load("res://Assets/Scene/Prepare Scene/panel_left.png")
	elif direction == "right":
		$Image.texture = load("res://Assets/Scene/Prepare Scene/panel_right.png")
		$Button.position.x *= -1.0


func _on_Clothes_pressed():
	print("Open clothes")


func _on_Gun_pressed():
	print("Open gun")


func _on_Button_add_button_down():
	print("Button add")
	$Button_remove.show()
	$Button_add.hide()
	$Button.show()


func _on_Button_remove_button_down():
	print("Button remove")
	$Button_remove.hide()
	$Button_add.show()
	$Button.hide()
