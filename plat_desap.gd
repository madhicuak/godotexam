extends Area2D

func _ready():
	monitorable = true
	monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
				PLAT_MOV_DESAP()
				await get_tree().create_timer(.5).timeout
				queue_free()

func PLAT_MOV_DESAP():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x +2, .1)
	tween.tween_property(self, "position:x", position.x -2, .1)
	tween.tween_property(self, "position:x", position.x +2, .1)
	tween.tween_property(self, "position:x", position.x -2, .1)
	tween.tween_property(self, "position:x", position.x +2, .1)
	tween.tween_property(self, "position:x", position.x -2, .1)
