extends Area2D
#@onready var game_manager: Node=%GameManager
#signal coinCollected 

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		body.agregar_moneda()
		queue_free()
#	coin += 1
	#queue_free()
	#pass Replace with function body.
