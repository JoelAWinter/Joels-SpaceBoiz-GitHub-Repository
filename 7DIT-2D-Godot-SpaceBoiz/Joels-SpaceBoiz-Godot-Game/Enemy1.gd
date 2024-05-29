extends CharacterBody2D

var player_chase = false
var speed = 40
var player = null

func _physics_process(delta):
	if player_chase:
		velocity = (player.position - position).normalized() * speed
		move_and_slide()

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true



func _on_area_2d_body_exited(body):
	player = body
	player_chase = null
