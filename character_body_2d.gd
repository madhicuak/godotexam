extends CharacterBody2D

var velocidad = 200
var brinco = -400
var gravedad = 1000
@onready var sprite = $AnimatedSprite2D
var ultima_direccion = 1  
<<<<<<< HEAD
var monedas: int = 0
=======
var vidas = 2
>>>>>>> 6a642818be531b712fbcb578c07fd8adad9bfaa8

func _ready():
	add_to_group("jugador")
	AnimVidas()
	

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

func ReducirVidas():
	if vidas > 0:
		vidas -= 1
#	else:
#		_on_reset_body_entered()
	pass

func AnimVidas():
	if vidas >= 3:
		$Node2D/vida_tres.visible = true
		$Node2D/vida_dos.visible = true
		$Node2D/vida_uno.visible = true
	if vidas < 3:
		$Node2D/vida_tres.visible = false
		$Node2D/vida_dos.visible = true
		$Node2D/vida_uno.visible = true
	if vidas < 2:
		$Node2D/vida_tres.visible = false
		$Node2D/vida_dos.visible = false
		$Node2D/vida_uno.visible = true
	else:
		pass

func _on_reset_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()

func _on_puerta_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("")

#________script_________contador_____________________
