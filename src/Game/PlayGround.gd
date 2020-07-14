extends Node2D



func _ready():
	$Camera/Player_tag/Player1.connect_player($Actors/Player1)
	$Camera/Player_tag/Player2.connect_player($Actors/Player2)
