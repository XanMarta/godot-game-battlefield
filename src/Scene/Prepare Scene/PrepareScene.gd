extends Node2D


func _ready():
	for panel in $Panel.get_children():
		panel.connect("freeze", self, "freeze")
		panel.connect("unfreeze", self, "unfreeze")


func freeze():
	for panel in $Panel.get_children():
		panel.freeze()
	$Black_screen.show()

func unfreeze():
	for panel in $Panel.get_children():
		panel.unfreeze()
	$Black_screen.hide()
