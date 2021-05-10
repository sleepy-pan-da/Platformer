extends Area2D

signal checkpt_passed

var on_state = false

onready var animatedsprite = $AnimatedSprite


func _on_Checkpoint_body_entered(body):
	if !on_state:
		animatedsprite.play("Animate")
		if GlobalScript.latest_checkpt != null: #not the first checkpt
			#print("1")
			emit_signal("checkpt_passed")
			update_previous_checkpt()
		else: #first checkpt
			#print("2")
			update_previous_checkpt()
		GlobalScript.latest_checkpt = global_position
		on_state = true
func update_previous_checkpt():
	GlobalScript.previous_checkpt = name
