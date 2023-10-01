extends Camera2D

var trauma : float

func _enter_tree():
	GameManager.on_level_reset.connect(_on_level_reset)
	
func _exit_tree():
	GameManager.on_level_reset.disconnect(_on_level_reset)
	
func _on_level_reset():
	trauma = 1.5

func _process(delta):
	if trauma > 0.0:
		trauma -= (delta * trauma * 5.0)
		offset = Vector2(1, 1) * (sin(Time.get_ticks_msec() * trauma) * trauma)
	elif offset.length_squared() != 0:
		offset = Vector2()
		
