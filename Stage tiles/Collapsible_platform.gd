extends StaticBody2D

onready var collapse_timer = $collapse_timer
onready var rebuild_timer = $rebuild_timer
onready var animatedsprite = $AnimatedSprite
onready var collisionshape = $CollisionShape2D

var rebuilt = true

func _on_Area2D_body_entered(body):
	if rebuilt:
		collapse_timer.start()
		#print("collapsing")


func _on_platform_timer_timeout():
	animatedsprite.play("Animate")
	

func _on_rebuild_timer_timeout():
	animatedsprite.play("Reverse_Animate")
	

func _on_AnimatedSprite_animation_finished():
	if animatedsprite.animation == "Animate":
		rebuilt = false
		collisionshape.disabled = true
		rebuild_timer.start()
		#print("2")
	elif animatedsprite.animation == "Reverse_Animate":
		rebuilt = true
		collisionshape.disabled = false
		#print("1")
		
