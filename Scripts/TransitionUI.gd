extends ColorRect

var target : float
var current : float

func _enter_tree():
	GameManager.on_level_won.connect(_on_level_won)
	GameManager.on_level_load.connect(_on_level_load)

func _on_level_won():
	#Active animation in forward order
	await get_tree().create_timer(0.5).timeout
	target = 0
	current = 1
	await get_tree().create_timer(2).timeout
	GameManager._load_next_level()
	
func _on_level_load():
	#Activate animation in reverse order
	target = 1
	current = 0
	
func _process(delta):
	if target != current:
		current = move_toward(current, target, delta)
		global_position = lerp(Vector2(-320, -180), Vector2(-320, -1000), current)
	

