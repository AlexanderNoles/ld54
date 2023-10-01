extends Control

@export var array = []

func _enter_tree():
	GameManager.on_level_load.connect(_ready)
	
func _exit_tree():
	GameManager.on_level_load.disconnect(_ready)
	
func _ready():
	for item in array:
		item.visible = true


