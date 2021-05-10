extends Node2D



	


func _on_Area2d_body_entered(body):
	body.you_died()
