extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var main_menu_button = preload("res://escena1.tscn")
	var buttons = ["Jugar","Salir"]
	for i in range(len(buttons)):
		var instance = main_menu_button.instance()
		instance.text = buttons[i]
		match i:
			0:
				instance.connect("pressed",self,"load_scene2",["res://escena1.tscn"])
			1:
				instance.connect("pressed",self,"quit")
		$Button.add_child(instance)
		$Button2.add_child(instance)
	
func load_scene2(scene) -> void:
	var error_code = get_tree().change_scene(scene)
	if error_code != 0:
		print("Error: ",error_code)

func quit() -> void:
	get_tree().quit()
