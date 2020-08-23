extends Node2D

signal change_clothes(body)
signal close


func _ready():
	for body in DataList.body_list:
		$Pickup/Body.add_item(body, DataList.body_texture[body])


func body_selected(index):
	var body = $Pickup/Body.get_item_text(index)
	emit_signal("change_clothes", body)
	print("Select body: ", body)


func exit_pressed():
	hide()
	emit_signal("close")
