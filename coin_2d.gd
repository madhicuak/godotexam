extends Area2D
#@onready var game_manager: Node=%GameManager

#signal coinCollected 

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	pass # Replace with function body.
