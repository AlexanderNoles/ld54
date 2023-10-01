extends AnimatedSprite2D

@onready var targetGrid = get_node("../../Grid")
@export var rawPos : Vector2
var currentPos : Vector2
var inputMask : Vector2 = Vector2(1, 1)
var inputDisabled : bool

var startingPos : Vector2
var flashEndTime : float

@export var positionIndicator : Node2D

signal on_move(grid_position)

func _ready():
	startingPos = position
	_reset()
	
func _reset():
	position = targetGrid.get_position_on_grid(targetGrid.clamp_position_to_grid(position))

	inputDisabled = false
	rawPos = position
	currentPos = position
	positionIndicator.position = position
	
func _enter_tree():
	GameManager.on_level_won.connect(_on_level_won)
	GameManager.on_level_reset.connect(_on_level_reset)
	
func _exit_tree():
	GameManager.on_level_won.disconnect(_on_level_won)
	GameManager.on_level_reset.disconnect(_on_level_reset)
	
func _on_level_won():
	inputDisabled = true
	play("leave")
	
func _on_level_reset():
	position = startingPos
	_reset()
	material.set_shader_parameter("intensity", 1.0)
	await get_tree().create_timer(0.5).timeout
	material.set_shader_parameter("intensity", 0.0)

func _input(event):
	if event is InputEventKey and !inputDisabled:
		var inputVec = Vector2(Input.get_axis("right", "left"), Input.get_axis("up", "down"))
		var finalInputVector = Vector2(inputMask.x * inputVec.x, inputMask.y * inputVec.y)
	
		var absVec = abs(inputVec)
		inputMask = Vector2(1, 1) - absVec
	
		if finalInputVector.length_squared() > 0:
			if(finalInputVector.x != 0):
				flip_h = finalInputVector.x < 0
			var previousRawPos = rawPos
			rawPos = targetGrid.get_position_on_grid(targetGrid.clamp_position_to_grid(rawPos + (finalInputVector * targetGrid.pixelScale)))
			if previousRawPos != rawPos:
				emit_signal("on_move", rawPos)

func _process(delta):
	positionIndicator.position = rawPos
	currentPos = lerp(currentPos, rawPos + Vector2(0, -3), delta * 35)
	
	position = currentPos
