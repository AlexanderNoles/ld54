extends Sprite2D

@export var positions = []
var positionIndex = 0
var originalPosition : Vector2
var rawPos : Vector2

func _enter_tree():
	originalPosition = position
	rawPos = originalPosition
	GameManager.on_level_reset.connect(_on_reset)
	
func _exit_tree():
	GameManager.on_level_reset.disconnect(_on_reset)
	
func _on_reset():
	position = originalPosition
	print(position)
	rawPos = position
	positionIndex = 0

func move():
	rawPos = positions[positionIndex]
	positionIndex += 1
	if positionIndex == positions.size():
		positionIndex -= 1
	
	return rawPos

func _process(delta):
	position = position.move_toward(rawPos, delta * 150.0)
