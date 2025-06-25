extends Area2D

func _ready():
	monitorable = true
	monitoring = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
				TRONC_MOV_DESAP()
				await get_tree().create_timer(1.3).timeout
				queue_free()

func TRONC_MOV_DESAP():
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y +2, .1)
	tween.tween_property(self, "position:y", position.y -2, .1)
	tween.tween_property(self, "position:y", position.y +2, .1)
	tween.tween_property(self, "position:y", position.y -2, .1)
	tween.tween_property(self, "position:y", position.y +2, .1)
	tween.tween_property(self, "position:y", position.y +2, .1)
	tween.tween_property(self, "position:y", position.y -2, .1)
	tween.tween_property(self, "position:y", position.y +2, .1)
	tween.tween_property(self, "position:y", position.y +100, .5)
