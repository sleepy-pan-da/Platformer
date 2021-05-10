extends Node2D


func _ready():
	for checkpt in get_children():
		checkpt.connect("checkpt_passed", self, "update_checkpt")

func update_checkpt():
	get_node(GlobalScript.previous_checkpt + "/AnimatedSprite").play("Animate_reverse")
	get_node(GlobalScript.previous_checkpt).on_state = false
