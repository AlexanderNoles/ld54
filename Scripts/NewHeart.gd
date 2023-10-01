extends Sprite2D

@export var player : Node2D
@export var particles : Node2D
var gameFinished : bool = false

func _process(delta):
	var extra = abs(sin(Time.get_ticks_msec() / 2000.0) * 0.625)
	scale = Vector2(1, 1) + Vector2(extra, extra)
	
	if player.global_position.distance_to(global_position) < 3 and !gameFinished:
		gameFinished = true
		player.inputDisabled = true
		player.play("leave")
		await get_tree().create_timer(0.5).timeout
		player.visible = false
		await get_tree().create_timer(1.0).timeout
		particles.emitting = true
		visible = false
		GameManager._win_level()
