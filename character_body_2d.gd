extends CharacterBody2D

var velocidad = 200
var brinco = -400
var gravedad = 1000
@onready var sprite = $AnimatedSprite2D
var ultima_direccion = 1  
var vidas = 3
var puede_moverse := true
var recibe_daño := false
var monedas := 0
var invulnerable := false
@onready var label_monedas: Label = $Camera2D/ui/MonedaNum


func _ready():
	add_to_group("jugador")
	AnimVidas()
	$musica/musiquita.play()
	$Camera2D/ui/GameOver.visible = false
	$Camera2D/ui/end.visible = false
	set_physics_process(true)
	$"Camera2D/ui/Panel-transparent-center-019".modulate.a = 0.5


func _physics_process(delta):
	if puede_moverse:
		var direccion = Input.get_axis("ui_left", "ui_right")
		velocity.x = direccion * velocidad
		
		if not is_on_floor():
			velocity.y += gravedad * delta
		if Input.is_action_just_pressed("ui_up") and is_on_floor():
			velocity.y = brinco
	else:
		if not is_on_floor():
			velocity.y += gravedad * delta

	move_and_slide()
	
	if puede_moverse:
		actualizar_animaciones(Input.get_axis("ui_left", "ui_right"))


func actualizar_animaciones(direccion):
	if recibe_daño:
		return
	
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


func ReducirVidas() -> void:
	if invulnerable == true:
		return
	if vidas > 1 and invulnerable == false:
		vidas -= 1
		AnimVidas()
		invulnerable = true
		puede_moverse = false
		recibe_daño = true
		sprite.play("daño")
		velocity = Vector2(-ultima_direccion * 250, -100)
		await get_tree().create_timer(0.3).timeout
		recibe_daño = false
		puede_moverse = true
		AnimDaño()
		await get_tree().create_timer(0.2).timeout
		invulnerable = false
	else:
		vidas -= 1
		$musica/musiquita.stop()
		$musica/gameover.play()
		$Camera2D/ui/GameOver.visible = true
		AnimVidas()
		puede_moverse = false
		invulnerable = true
		set_physics_process(false)
		sprite.play("daño")
		await get_tree().create_timer(0.5).timeout
		sprite.play("muerte")
		await get_tree().create_timer(1.0).timeout
		sprite.visible = false
		await get_tree().create_timer(2.5).timeout
		get_tree().reload_current_scene()

func AnimDaño():
	sprite.visible = false
	await get_tree().create_timer(0.1).timeout
	sprite.visible = true
	await get_tree().create_timer(0.1).timeout
	sprite.visible = false
	await get_tree().create_timer(0.1).timeout
	sprite.visible = true
	await get_tree().create_timer(0.1).timeout
	sprite.visible = false
	await get_tree().create_timer(0.1).timeout
	sprite.visible = true

func AnimVidas():
	if vidas == 3:
		$Camera2D/ui/vida_tres.visible = true
		$Camera2D/ui/vida_dos.visible = true
		$Camera2D/ui/vida_uno.visible = true
		$Camera2D/ui/sano.visible = true
	elif vidas == 2:
		$Camera2D/ui/vida_tres.visible = false
		$Camera2D/ui/vida_dos.visible = true
		$Camera2D/ui/vida_uno.visible = true
		$Camera2D/ui/sano.visible = false
	elif vidas == 1:
		$Camera2D/ui/vida_tres.visible = false
		$Camera2D/ui/vida_dos.visible = false
		$Camera2D/ui/vida_uno.visible = true
		$Camera2D/ui/sano.visible = false
		$Camera2D/ui/herido.visible = false
	elif vidas <= 0:
		$Camera2D/ui/vida_tres.visible = false
		$Camera2D/ui/vida_dos.visible = false
		$Camera2D/ui/vida_uno.visible = false
		$Camera2D/ui/sano.visible = false
		$Camera2D/ui/herido.visible = false
		$Camera2D/ui/moribundo.visible = false
	else:
		pass

func agregar_moneda():
	monedas += 1
	label_monedas.text = str(monedas)

func total_mon():
	$Camera2D/ui/end.visible = true
	$Camera2D/ui/end/Total_monedas.text = "Monedas obtenidas: %d" % monedas
	$Camera2D/ui/end/monedas_nivel.text = "26 monedas en el nivel"
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = false
	await get_tree().create_timer(0.15).timeout
	$Camera2D/ui/end/monedas_nivel.visible = true


func _on_reset_body_entered(body: Node2D) -> void:
	if is_in_group("jugador"):
		vidas -= 3
		ReducirVidas()
	else:
		return

func _on_puerta_body_entered(body: Node2D) -> void:
	$musica/musiquita.stop()
	$musica/stage.play()
	invulnerable = true
	puede_moverse = false
	sprite.position = Vector2(5,-30)
	await get_tree().create_timer(.15).timeout
	sprite.visible = false
	total_mon()
	await get_tree().create_timer(4.35).timeout
	get_tree().change_scene_to_file("res://Assets/interior/node_2d.tscn")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("dmgbox"):
		ReducirVidas()

func _on_murci_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		vidas -= 3
		ReducirVidas()
