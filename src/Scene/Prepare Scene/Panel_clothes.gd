extends Node2D


signal exit
signal change_clothes(body)



func _ready():
	for i in range(5):
		for body in DataList.body_list:
			$Pickup/Body.add_item(body + str(i), DataList.body_texture[body])


func body_selected(index):
	var body = $Pickup/Body.get_item_text(index)
	emit_signal("change_clothes", body)
	print("Select body: ", body)
