extends Area2D

signal youwin


func _on_Youwin_body_entered(body):
	emit_signal("youwin")
