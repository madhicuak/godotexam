extends Area2D

enum NPCType {BARBON, HATMAN, OLDMAN, WOMAN}
@export var type: NPCType = NPCType.BARBON;
var direccion = 1
var ultima_direccion = 1  
@onready var sprite = $AnimatedSprite2D

func _ready():
	monitorable = true
	monitoring = true
	NPC_MOV()
	ActuNPC()

func ActuNPC():
	match type:
		NPCType.BARBON:
			ANIM_BARBON(direccion)
			NPC_MOV()
		NPCType.HATMAN:
			NPC_MOV()
		NPCType.OLDMAN:
			NPC_MOV()
		NPCType.WOMAN:
			NPC_MOV()

func ANIM_BARBON(direccion):
	if direccion != 0:
		ultima_direccion = direccion
	else:
		if direccion == 0:
			sprite.play("barbon")
		else:
			sprite.play("barbon_mov")
	
	sprite.flip_h = ultima_direccion < 0

func NPC_MOV():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x +100, 2)
	tween.tween_interval(1)
	tween.tween_property(self, "position:x", position.x -100, 2)
	tween.tween_interval(1)
	tween.set_loops()
