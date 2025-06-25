extends CharacterBody2D

@export var velocidad := 40
@export var gravedad := 1000
@export var patrulla := 100
@export var daño := 1
@onready var sprite_enemigo = $AnimatedSprite2D

var direction := -1
var start_position := Vector2.ZERO

func _ready():
	start_position = global_position
	sprite_enemigo.play("moco")

func _physics_process(delta):
	velocity.x = direction * velocidad


	if not is_on_floor():
		velocity.y += gravedad * delta
	else:
		velocity.y = 0

	move_and_slide()

	if abs(global_position.x - start_position.x) > patrulla:
		direction *= -1
		sprite_enemigo.flip_h = direction > 0

func _on_HurtBox_area_entered(area):
	if area.is_in_group("player_attack"):
		die()

func die():
	queue_free()
