extends CharacterBody2D

var player_chase = false
var speed = 60
var player = null
var health = 240
var player_inattack_zone = false
var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()
	
	if player_chase:
		velocity = (player.position - position).normalized() * speed
		move_and_collide(velocity * delta)

func _on_area_2d_body_entered(body):
	player = body
	player_chase = true

func _on_area_2d_body_exited(body):
	player = body
	player_chase = null
	
func enemy():
	pass

func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_inattack_zone = true


func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage = false
			print("slime health = ", health)
			if health <= 0:
				self.queue_free()
				#get_tree().change_scene_to_file("res://scenes/main menu/main_menu.tscn")


func _on_take_damage_cooldown_timeout():
	can_take_damage = true
