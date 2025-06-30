extends Area2D

@export var velocidad := 60

func _physics_process(delta):
	position.x += velocidad * delta

func _on_area_entered(area):
	if area.is_in_group("jugador"):
		print("El muro tocó al jugador!")
		area.ReducirVidas()
