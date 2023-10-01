extends Sprite2D

@export var numbers = []
var currentNumber : int

func _enter_tree():
	GameManager.on_level_reset.connect(_on_level_reset)
	
func _exit_tree():
	GameManager.on_level_reset.disconnect(_on_level_reset)
	
func _on_level_reset():
	currentNumber = 0
	_update_sprite()

func _on_player_on_move(grid_position):
	currentNumber += 1
	_update_sprite()
	
func _update_sprite():
	texture = numbers[currentNumber]
