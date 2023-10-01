extends Sprite2D

@onready var targetGrid = get_node("../../Grid")
@export var open : bool
@export var child : Node2D

func _ready():
	global_position = targetGrid.get_position_on_grid(global_position)
	_child_update()
	
func _set_open(_bool : bool):
	open = _bool
	_child_update()
	
func _child_update():
	child.visible = !open
