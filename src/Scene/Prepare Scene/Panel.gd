extends Node2D


export var direction = "left"


var current_hat = ""
var current_body = "Blue"
var current_gun = "PT01"



func _ready():
	if direction == "left":
		$Image.texture = load("res://Assets/Scene/Prepare Scene/panel_left.png")
		$Slide/Image.texture_progress = load("res://Assets/Scene/Prepare Scene/panel_empty_left.png")
	elif direction == "right":
		$Image.texture = load("res://Assets/Scene/Prepare Scene/panel_right.png")
		$Slide/Image.texture_progress = load("res://Assets/Scene/Prepare Scene/panel_empty_right.png")
		$Button.position.x *= -1.0
		$Player.scale.x *= -1.0
		$Clothes_Gun.position.x *= -1.0
	update()


func update():
	$Player/Body.texture = DataList.body_texture[current_body]
	if current_gun != null:
		$Player/Gun.texture = DataList.gun_texture[current_gun]
	else:
		$Player/Gun.texture = null


func _on_Clothes_pressed():
	print("Open clothes")
	$Clothes_Gun/Panel_clothes.show()


func _on_Gun_pressed():
	print("Open gun")



func _on_Button_add_button_down():
	print("Button add")
	$Button_add/Button_remove.show()
	$Button_add/Button_add.hide()
	$Button.show()
	$Slide/AnimationPlayer.play("disappear")


func _on_Button_remove_button_down():
	print("Button remove")
	$Button_add/Button_remove.hide()
	$Button_add/Button_add.show()
	$Button.hide()
	$Slide/AnimationPlayer.play("appear")


func change_clothes(body):
	current_body = body
	update()
