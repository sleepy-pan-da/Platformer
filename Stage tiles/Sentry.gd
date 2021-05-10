extends StaticBody2D

var Projectile = preload("res://Stage tiles/Sentry_projectile.tscn")
var projectile_max_speed = 100
export (bool) var facing_right
onready var sprite = $Sprite
onready var firingposition = $Muzzle

func _ready():
	if !facing_right:
		sprite.flip_h = true
		firingposition.position.x *= -1

func _on_Bullet_timer_timeout():
	var projectile = Projectile.instance()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position = firingposition.global_position
	if sprite.flip_h:
		projectile.velocity = Vector2(-projectile_max_speed, 0)
	else:
		projectile.velocity = Vector2(projectile_max_speed, 0)
