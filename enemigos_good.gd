extends CharacterBody2D

@export var speed := 40
@export var gravity := 500
@export var patrol_distance := 100
@export var damage := 1

var direction := -1
var start_position := Vector2.ZERO

func _ready():
	start_position = global_position

func _physics_process(delta):
	velocity.x = direction * speed


	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0

	move_and_slide()

	if abs(global_position.x - start_position.x) > patrol_distance:
		direction *= -1
		#$Sprite.flip_h = direction > 0

func _on_HurtBox_area_entered(area):
	if area.is_in_group("player_attack"):
		die()

func die():
	queue_free()
