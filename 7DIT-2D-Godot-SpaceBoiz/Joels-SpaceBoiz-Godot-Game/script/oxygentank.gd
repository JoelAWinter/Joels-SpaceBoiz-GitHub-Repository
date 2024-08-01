extends Area2D



@onready var anim = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name == "player":
		anim.play("Collected")
		global.oxygen_bar += 20
		print(global.oxygen_bar)
		await anim.animation_finished
		queue_free()
