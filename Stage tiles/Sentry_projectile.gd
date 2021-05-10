extends KinematicBody2D

var velocity : Vector2

	
func _physics_process(delta):
	velocity = move_and_slide(velocity)

func _on_Hitbox_body_entered(body):
	if body.name == "Player":
		body.you_died()
	queue_free()
	


