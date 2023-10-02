extends Sprite2D

@export var positions = []
@export var nextPosIndicator : Node2D
var positionIndex = 0
var originalPosition : Vector2
var rawPos : Vector2
var foreverHide : bool

func _enter_tree():
	originalPosition = position
	rawPos = originalPosition
	nextPosIndicator.position = positions[0] - rawPos
	GameManager.on_level_reset.connect(_on_reset)
	
func _exit_tree():
	GameManager.on_level_reset.disconnect(_on_reset)
	
func _on_reset():
	position = originalPosition
	rawPos = position
	nextPosIndicator.position = positions[0] - rawPos
	positionIndex = 0
	foreverHide = false

func move(moveSound):
	var previousPos = rawPos
	rawPos = positions[positionIndex]
	positionIndex += 1
	if positionIndex == positions.size():
		positionIndex -= 1
		foreverHide = true
	elif previousPos != rawPos:
		moveSound.play()
		nextPosIndicator.position = positions[positionIndex] - rawPos
		nextPosIndicator.visible = false
	
	return rawPos

func _process(delta):
	position = position.move_toward(rawPos, delta * 150.0)
	nextPosIndicator.visible = position == rawPos && !foreverHide
