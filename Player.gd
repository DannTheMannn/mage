extends KinematicBody2D

const TARGET_FPS = 60
const ACCELERATION = 8
const MAX_SPEED = 64
const FRICTION = 10
const AIR_RESISTANCE = 1
const GRAVITY = 4
const JUMP_FORCE = 140
const SHOOT_DOWN_PUSH = 60

var motion = Vector2.ZERO

onready var sprite = $Sprite
onready var animationPlayer = $AnimationPlayer
onready var shootTimer = $shootTimer

func _physics_process(delta):

	

	animationPlayer.play("Run")
	motion.x +=  ACCELERATION * delta * TARGET_FPS
	motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)


	
	motion.y += GRAVITY * delta * TARGET_FPS
	if Input.is_action_pressed("ui_shootF"):
		print("shootf")
	elif Input.is_action_pressed("ui_shootU"):
		print("shhotup")
	elif Input.is_action_pressed("ui_shootD") and shootTimer.time_left == 0:
		shootTimer.start()
		motion.y = -SHOOT_DOWN_PUSH
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_FORCE
	else:
		animationPlayer.play("Jump")
		
		if Input.is_action_just_released("ui_up") and motion.y < -JUMP_FORCE/2:
			motion.y = -JUMP_FORCE/2
		

	
	motion = move_and_slide(motion, Vector2.UP)
