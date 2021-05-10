extends Node2D

var myscene = "res://Levels/World1.tscn"
var nextscene = "res://Levels/World2.tscn"
var deatheffect = preload("res://Player/DeathEffect.tscn")
onready var camera = $Camera2D
onready var player = $Player
onready var fps_label = $CanvasLayer/fps_label
onready var youwin = $Youwin
onready var winlabel = $Label3
onready var music = $Music
onready var deathsound = $Deathsound

func _ready():
	player.connect("youdied", self, "restart_stage")
	#$Player.connect("youleftthescreen", self, "transition_camera")
	youwin.connect("youwin", self, "show_msg")

func _physics_process(delta):
	fps_label.set_text(str(Engine.get_frames_per_second()))
	#restart lvl - helps in testing
	transition_camera()
	if Input.is_action_just_pressed("restart"):
		restart_stage()

func restart_stage():
	print(1)
	var Deatheffect = deatheffect.instance()
	get_tree().current_scene.add_child(Deatheffect)
	Deatheffect.global_position = GlobalScript.player_dead_position
	if Deatheffect.global_position != GlobalScript.latest_checkpt:
		Deatheffect.emitting = true
	deathsound.play()
	#respawn
	player.global_position = GlobalScript.latest_checkpt   


func transition_camera():
	if player.global_position.x > camera.global_position.x + 320:
		camera.global_position.x += 640
	elif player.global_position.x < camera.global_position.x - 320:
		camera.global_position.x -= 640
	elif player.global_position.y < camera.global_position.y - 180:
		camera.global_position.y  -= 360
	elif player.global_position.y > camera.global_position.y + 180:
		camera.global_position.y += 360

func show_msg():
	winlabel.show()


func _on_Music_timer_timeout():
	music.play()
