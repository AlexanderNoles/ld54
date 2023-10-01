extends Control

@export var target : Control

@export var matchX : bool
@export var matchY : bool

@export var buffer : Vector2

func _ready():
	target.resized.connect(onSizeUpdate)
	onSizeUpdate()

func onSizeUpdate():
	var newSize = target.size + (buffer * 2)
	
	if !matchX:
		newSize.x = size.x
		
	if !matchY:
		newSize.y = size.y
	
	set_size(newSize)
	position = -buffer
