extends Sprite2D


func _ready():
	await get_tree().create_timer(2.5).timeout
	get_tree().quit()
