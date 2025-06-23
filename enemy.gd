extends CharacterBody2D
var is_following_player = false 
var player : CharacterBody2D = null 
const SPEED = 150


func _player_process (delta):
	if is_following_player: 
		var direction =(player.position -  position).normalized() 
		velocity = direction*SPEED
		move_and_slide()
		
		

func _on_area_2d_body_entered(body: Node2D) -> void:
	is_following_player=true 
#	player = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_following_player = false 
