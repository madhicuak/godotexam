extends Area2D

enum AguaType {verde, rojo}
@export var type: AguaType = AguaType.verde;

func _ready():
	ActuPlat()
	monitorable = true
	monitoring = true

func ActuPlat():
	match type:
		AguaType.verde:
			modulate.a = 0.7
			AGUA_MOV()
		AguaType.rojo:
			modulate.a = 0.9
			$TileMapLayer.modulate = Color.RED
			LAVA_MOV()

func AGUA_MOV():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x +10, .5)
	tween.tween_property(self, "position:y", position.y +2, .2)
	tween.tween_property(self, "position:x", position.x -10, .5)
	tween.tween_property(self, "position:y", position.y -2, .2)
	tween.set_loops()

func LAVA_MOV():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x +10, 1.5)
	tween.tween_property(self, "position:y", position.y +2, .2)
	tween.tween_property(self, "position:x", position.x -10, 1.5)
	tween.tween_property(self, "position:y", position.y -2, .2)
	tween.set_loops()
