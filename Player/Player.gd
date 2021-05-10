extends KinematicBody2D

signal youdied

const MAXSPEED = 120
const GRAVITY = 10
const JUMP_POWER = -250
const WALLJUMP_POWER = -200
const FLOOR_NORMAL = Vector2(0, -1)
const ACCELERATION = 1000
const FRICTION = 1000
const AIR_FRICTION = 400
const WALLSLIDE_VELOCITY = 7

var direction
var walldirection
var velocity = Vector2()
var facing_right = true
var on_moving_platform = false

#things determining whether can jump
var jumped
var timerstarted = false
var wallsliding = false
var walljumped = false

onready var sprite = $Sprite
onready var animationplayer = $AnimationPlayer
onready var raycast = $Jump_RayCast2D
onready var coyote_timer = $Coyote_timer
onready var walljump_timer = $Walljump_timer
onready var leftwall_raycast = $Wall_RayCasts/LeftWall_Raycasts
onready var rightwall_raycast = $Wall_RayCasts/RightWall_Raycasts

func _physics_process(delta):
	if !walljumped:
		update_wall_direction()
	else:
		walldirection = 0
		
	if Input.is_action_pressed("ui_right"):
		direction = 1
		facing_right = true
	elif Input.is_action_pressed("ui_left"):
		direction = -1
		facing_right = false
	else:
		direction = 0
	
	#acceleration 
	if direction == 1 or direction == -1:
		#print("moving linearly")
		velocity.x += direction * (ACCELERATION * delta)
		if velocity.x > MAXSPEED:
			velocity.x = MAXSPEED
		elif velocity.x < -MAXSPEED:
			velocity.x = -MAXSPEED
	else:
		#deceleration
		if velocity.x > 10:
			if is_on_floor():
				velocity.x += -1 * (FRICTION * delta)
			else:
				velocity.x += -1 * (AIR_FRICTION * delta)
		elif velocity.x < -10:
			if is_on_floor():
				velocity.x += 1 * (FRICTION * delta)
			else:
				velocity.x += 1 * (AIR_FRICTION * delta)
		else:
			velocity.x = 0
			
	sprite.flip_h = true if !facing_right else false
	
	#coyote timer
	if !jumped && !is_on_floor():
		if !timerstarted:
			#print("you are falling")
			coyote_timer.start()
			timerstarted = true

	

	if is_on_floor():
		wallsliding = false
		jumped = false
		timerstarted = false
		if direction == 0:
			animationplayer.play("idle")
		else:
			animationplayer.play("run")
	else:
		animationplayer.play("in_air")
		if walldirection != 0:
			wallsliding = true
			if velocity.y > 0:
				velocity.y += -WALLSLIDE_VELOCITY
				if velocity.y > 80:
					velocity.y = 80
		else:
			wallsliding = false
				
			
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() or raycast.is_colliding():
			velocity.y = JUMP_POWER
			jumped = true
			#print("jump1")
		elif wallsliding:
			velocity.y = WALLJUMP_POWER
			velocity.x = -walldirection * 200
			jumped = true
			wallsliding = false
			walljumped = true
			walljump_timer.start()
			#print("jump2")
		elif timerstarted:
			if coyote_timer.time_left > 0:
				velocity.y = JUMP_POWER
				jumped = true
				coyote_timer.stop()
				timerstarted = false
				#print("jump3")
				
	if Input.is_action_just_released("jump"):
		if !is_on_floor() and !wallsliding:
			if velocity.y < 0:
				velocity.y *= 0.5
				#print("shorter jump")
	
	if on_moving_platform:
		velocity = Vector2.ZERO
	
	velocity = move_and_slide(velocity, FLOOR_NORMAL) #helps resolve increasing gravity problem
	#print(velocity.x)
	velocity.y += GRAVITY
	
	
func you_died():
	GlobalScript.player_dead_position = global_position
	emit_signal("youdied")
	
func check_wall(wall_raycasts):
	for raycast in wall_raycasts.get_children():
		if raycast.is_colliding():
			return true
	return false

func update_wall_direction():
	var near_left_wall = check_wall(leftwall_raycast)
	var near_right_wall = check_wall(rightwall_raycast)
	
	if near_left_wall and near_right_wall:
		walldirection = direction
	else:
		walldirection = -int(near_left_wall) + int(near_right_wall)







func _on_Walljump_timer_timeout():
	walljumped = false


	


