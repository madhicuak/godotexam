extends Node2D

@export var velocidad := 50

func _physics_process(delta):
	position.x += velocidad * delta

func _on_body_entered(body):
	if body.is_in_group("jugador"):
		body.ReducirVidas()
