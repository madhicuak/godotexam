extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		if body.vidas < 3:
			body.vidas += 1
			body.AnimVidas()
		queue_free()
