extends Area2D

@export var distancia := 5
@export var velocidad: float = 1
var distancia_recorrida = 0

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	position.x += velocidad * delta
	distancia_recorrida += abs(velocidad * delta)
	
	if distancia_recorrida >= distancia:
		queue_free()

func _on_area_entered(area):
	if area.is_in_group("jugador"):
		print("Jugador tocado por murci")
		area.ReducirVidas()
