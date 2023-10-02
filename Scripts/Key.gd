extends AnimatedSprite2D

@onready var targetGrid = get_node("../../Grid")
@onready var exitDoorway = get_node("../ExitDoorway")
@export var particles : Node2D
var keyGrabbed : bool = false

@export var keyPickupSound : AudioStreamPlayer2D

func _ready():
	global_position = targetGrid.get_position_on_grid(global_position)
	
func _enter_tree():
	GameManager.on_level_reset.connect(_on_reset)
	
func _exit_tree():
	GameManager.on_level_reset.disconnect(_on_reset)
	
func _on_reset():
	keyGrabbed = false
	play("default")
	particles.emitting = false
	exitDoorway._set_open(false)

func _on_player_on_move(grid_position):
	if grid_position.distance_to(global_position) < 3 && !keyGrabbed:
		keyGrabbed = true
		keyPickupSound.play()
		play("keyGrabbed")
		particles.emitting = true
		exitDoorway._set_open(true)
