extends Node2D

signal change_gun(gun)



func _ready():
	$Gunlist.add_item("No gun")
	for gun in Gunlist.gunlist:
		$Gunlist.add_item(gun, DataList.gun_texture[gun])


func item_selected(index):
	var gun = $Gunlist.get_item_text(index)
	if gun != "No gun":
		$Info_gun/Image.texture = DataList.gun_texture[gun]
		$Info_gun/Gun_name.text = Gunlist.gun[gun]["name"]
		$Info_gun/Damage.text = str(Gunlist.gun[gun]["damage"])
		$Info_gun/Recoil.text = str(Gunlist.gun[gun]["recoil"])
		$Info_gun/Firerate.text = str(Gunlist.gun[gun]["firerate"])
		$Info_gun/Capacity.text = str(Gunlist.gun[gun]["capacity"])
	else:
		$Info_gun/Image.texture = null
		$Info_gun/Gun_name.text = ""
		$Info_gun/Damage.text = ""
		$Info_gun/Recoil.text = ""
		$Info_gun/Firerate.text = ""
		$Info_gun/Capacity.text = ""
	emit_signal("change_gun", gun)


func exit_pressed():
	print("Exit")
	hide()
