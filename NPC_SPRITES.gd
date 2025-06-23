extends AnimatedSprite2D

enum NPCType {BARBON, HATMAN, OLDMAN, WOMAN}
@export var type: NPCType = NPCType.BARBON;
var direccion = 1
var ultima_direccion = 1  
@onready var sprite = $AnimatedSprite2D

func _ready():
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

func NPC_MOV():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x +100, 2)
	await get_tree().create_timer(.2).timeout
	tween.tween_property(self, "position:x", position.x -100, 2)
	tween.set_loops()
