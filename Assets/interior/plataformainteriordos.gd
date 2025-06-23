extends Area2D


enum PlatformType {FIJA, MOVIL, DESAP, BRINCO, ICE}
@export var type: PlatformType = PlatformType.FIJA;
@export var rebote := 2.0

func _ready():
	ActuPlat()
	monitorable = true
	monitoring = true

func ActuPlat():
	match type:
		PlatformType.FIJA:
			$Sprite2D.modulate = Color.CORNFLOWER_BLUE
		PlatformType.MOVIL:
			$Sprite2D.modulate = Color.LIGHT_BLUE
			PLAT_MOV()
		PlatformType.DESAP:
			$Sprite2D.modulate = Color.INDIAN_RED
		PlatformType.BRINCO:
			$Sprite2D.modulate = Color.GOLDENROD
		PlatformType.ICE:
			$Sprite2D.modulate = Color.CYAN

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("jugador"):
		match type:
			PlatformType.DESAP:
				await get_tree().create_timer(1).timeout
				queue_free()
			PlatformType.BRINCO:
				if body.has_method("puede_rebotar"):
					body.puede_rebotar(rebote)
				else: 
					body.velocity.y = body.brinco * rebote
			PlatformType.ICE:
				body.velocity.x = body.velocidad * 2

func PLAT_MOV():
	var tween = create_tween()
	tween.tween_property(self, "position:x", position.x +100, 2)
	tween.tween_property(self, "position:x", position.x -100, 2)
	tween.set_loops()
