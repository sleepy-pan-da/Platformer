extends Node2D

func _physics_process(delta):
	#restart lvl - helps in testing
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://Levels/World2.tscn")
