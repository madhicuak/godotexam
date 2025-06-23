extends CharacterBody2D

var velocidad = 200
var brinco = -400
var gravedad = 1000
@onready var sprite = $AnimatedSprite2D
var ultima_direccion = 1  
var monedas: int = 0

func _ready():
	add_to_group("jugador")
	

func _physics_process(delta):
	var direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * velocidad
	
	if not is_on_floor():
		velocity.y += gravedad * delta
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = brinco
	
	move_and_slide()
	actualizar_animaciones(direccion)

func actualizar_animaciones(direccion):
	if direccion != 0:
		ultima_direccion = direccion
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("salto")
		else:
			sprite.play("caida")
	else:
		if direccion == 0:
			sprite.play("idle")
		else:
			sprite.play("derecha")
	
	sprite.flip_h = ultima_direccion < 0

func _on_reset_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()

func _on_puerta_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("")

#________script_________contador_____________________
