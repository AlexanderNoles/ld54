extends ColorRect

@export var distanceToCenter : float
var currentDistanceValue : float
var startingDistance : float

signal on_player_kill
signal on_state_updated(grid_position)

func _ready():
	material.set_shader_parameter("_distance", 50.0)
	currentDistanceValue = 50.0
	var previousDist = distanceToCenter
	distanceToCenter = roundf(distanceToCenter)
	
	if previousDist < distanceToCenter:
		distanceToCenter -= 0.5
	else:
		distanceToCenter += 0.5
		
	
	startingDistance = distanceToCenter
		
func _enter_tree():
	GameManager.on_level_reset.connect(_on_level_reset)
	
func _exit_tree():
	GameManager.on_level_reset.disconnect(_on_level_reset)
	
func _on_level_reset():
	distanceToCenter = startingDistance

func _process(delta):
	currentDistanceValue = lerpf(currentDistanceValue, distanceToCenter, delta * 5)
	
	material.set_shader_parameter("_distance", currentDistanceValue)

func _on_player_on_move(playerPos : Vector2):
	distanceToCenter -= 1.0;
	
	if maxf(playerPos.length() - 8.0, 0.0) >= distanceToCenter * 16:
		emit_signal("on_player_kill")
	emit_signal("on_state_updated", playerPos)
