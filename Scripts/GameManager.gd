extends Node

signal on_level_won

signal on_level_reset
signal on_level_load

var currentLevelIndex : int

func _ready():
	currentLevelIndex = 0
	emit_signal("on_level_load")

func _win_level():
	print("won!")
	emit_signal("on_level_won")
	
func _load_next_level():
	currentLevelIndex += 1;
	emit_signal("on_level_load")
	var path = "res://Levels/level" + str(currentLevelIndex) + ".tscn"
	get_tree().change_scene_to_file(path)
	
func _reset_level():
	print("reset :(")
	emit_signal("on_level_reset")

