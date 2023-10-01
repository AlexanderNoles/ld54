extends Sprite2D

@export var confirmEffect : Control
var buttonPressed : bool

func _input(event):
	if event is InputEventKey:
		var inputVec = Vector2(Input.get_axis("right", "left"), Input.get_axis("up", "down"))
		
		if inputVec.length_squared() > 0.0:
			buttonPressed = true
			GameManager._win_level()
			
func _process(delta):
	if buttonPressed:
		confirmEffect.size = confirmEffect.size.lerp(Vector2(97, 13), delta * 10.0)
