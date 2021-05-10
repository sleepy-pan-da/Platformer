extends KinematicBody2D

const shiftdistance = 100
const speed = 50

var leftmost = -shiftdistance
var rightmost = shiftdistance
var direction = 1 #1 is right, -1 is left
var distancefromcenter = 0
var velocity
	

func _physics_process(delta):
	velocity = move_and_slide(Vector2(speed * direction, 0))
	distancefromcenter += speed * direction * delta
	#print(distancefromcenter)
	if abs(distancefromcenter) >= shiftdistance:
		direction *= -1
		print(direction)




func _on_Area2D_body_entered(body):
	body.on_moving_platform = true


func _on_Area2D_body_exited(body):
	body.on_moving_platform = false
