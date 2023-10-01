@tool
extends TextureRect

@export var gridScale : int
@export var exitDoorway : Node2D
@export var obstaclesEmpty : Node2D
@export var devilsEmpty : Node2D
const pixelScale = 16
var playerDead : bool

func _ready():
	playerDead = false
	size = Vector2((gridScale * pixelScale) + 1, (gridScale * pixelScale) - 1)
	position = -Vector2(gridScale, gridScale) * (pixelScale * 0.5)
	
func _process(_delta):
	if Engine.is_editor_hint():
		_ready()

func get_position_on_grid(pos: Vector2):
	var toReturn = Vector2(roundf(pos.x / pixelScale) * pixelScale, roundf(pos.y / pixelScale) * pixelScale)
	
	if gridScale % 2 != 1.0:
		toReturn += Vector2(0.5, 0.5) * pixelScale
		
	return toReturn
	
func clamp_position_to_grid(pos: Vector2):
	
	var halfGridScale = gridScale * 0.5
	return Vector2(
		clampf(pos.x, (-pixelScale * halfGridScale) + 1, (pixelScale * halfGridScale) - 1),
		clampf(pos.y, (-pixelScale * halfGridScale) + 1, (pixelScale * halfGridScale) - 1)
	)


func _win_check(grid_position):
	
	for i in obstaclesEmpty.get_children():
		if grid_position.distance_to(i.global_position) < 5:
			playerDead = true
			break
			
	for i in devilsEmpty.get_children():
		var newDevilPos = i.move()
		
		if grid_position.distance_to(newDevilPos + global_position) < 5:
			playerDead = true
			break
	
	if playerDead:
		await get_tree().create_timer(0.05).timeout
		GameManager._reset_level()
		playerDead = false
	elif grid_position.distance_to(exitDoorway.global_position) < 5 && exitDoorway.open:
		GameManager._win_level()

func _on_color_rect_on_player_kill():
	playerDead = true
