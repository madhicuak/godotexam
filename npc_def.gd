extends CharacterBody2D

enum NPC_DType {barbon, morro, señora, viejo}
@export var velocidad := 60
@export var gravedad := 1000
@export var patrulla := 30
@export var daño := 1
@export var type: NPC_DType = NPC_DType.barbon;
@onready var sprite_npc = $spritenpc

var direction := -1
var start_position := Vector2.ZERO

func _ready():
	start_position = global_position
	ActuNPC()
	collision_layer = 1
	collision_mask = 1

func _physics_process(delta):
	velocity.x = direction * velocidad

	if not is_on_floor():
		velocity.y += gravedad * delta
	else:
		velocity.y = 0

	move_and_slide()

	if abs(global_position.x - start_position.x) > patrulla:
		direction *= -1
		sprite_npc.flip_h = direction < 0


func ActuNPC():
	match type:
		NPC_DType.barbon:
			sprite_npc.play("barbon_mov")
			velocidad = 40
		NPC_DType.morro:
			sprite_npc.play("hatman_mov")
			velocidad = 90 
		NPC_DType.señora:
			sprite_npc.play("woman_mov")
			patrulla = 30
		NPC_DType.viejo:
			sprite_npc.play("olman_mov")
			patrulla = 20
			velocidad = 20
