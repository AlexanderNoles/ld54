extends Sprite2D

@onready var targetGrid = get_node("../Grid")

func _ready():
	position = targetGrid.get_position_on_grid(position)	
