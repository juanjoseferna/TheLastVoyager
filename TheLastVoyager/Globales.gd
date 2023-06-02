extends Node

var flipflop
var jugador_pos

func _ready():
	pass

func muerte():
	get_tree().change_scene("res://menu.tscn")
