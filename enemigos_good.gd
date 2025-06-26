extends CharacterBody2D

enum EnemType {moco, ghost, ghoul, skeleton}
@export var velocidad := 60
@export var gravedad := 1000
@export var patrulla := 50
@export var daño := 1
@export var type: EnemType = EnemType.moco;
@onready var sprite_enemigo = $AnimatedSprite2D

var direction := -1
var start_position := Vector2.ZERO

func _ready():
	start_position = global_position
	ActuMons()

func ActuMons():
	match type:
		EnemType.moco:
			sprite_enemigo.play("moco")
			velocidad = velocidad * .6
		EnemType.ghost:
			sprite_enemigo.play("ghost")
			gravedad = 0
			$dmgbox.scale = Vector2(0.8, 0.8)
			$CollisionShape2D.disabled = true
		EnemType.ghoul:
			sprite_enemigo.play("ghoul")
			velocidad = 120
			patrulla = 80
		EnemType.skeleton:
			sprite_enemigo.play("skeleton")
			patrulla = patrulla * .5

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
	sprite_enemigo.play("die")
	queue_free()
