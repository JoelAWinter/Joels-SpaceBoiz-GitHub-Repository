extends CharacterBody2D

const speed = 100

var current_dir = "none"
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	update_health()
	enemy_attack()
	attack()

	if health <= 0:
		player_alive = false
		get_tree().change_scene_to_file("res://scenes/main menu/main_menu.tscn")

func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
			
func player():
	pass
	
func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = true
	

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range = false

func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("player health = ", health)	

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		
func _on_deal_attck_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false

func update_health():
	var healthbar = $healthbar
	healthbar.value = health

func _on_regin_timer_timeout():
	if health < 100:
		health = health + 20
		if health > 100:
			health = 100
	if health <= 0:
		health = 0
