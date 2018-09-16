extends KinematicBody2D

signal health_changed
signal dead #for death status and death animations
signal knocked_down #knock down status and animation




export (PackedScene) var Bullet # for Thrown Obejcts
export (int) var speed 
export (float) var rotation_speed #for character rotation
export (int) var health

var velocity = Vector2()
var can_throw = true
var alive = true #Death animation
var knocked_down = false #Knocked down animation

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():

	pass

func control(delta):
	
	pass

func _physics_process(delta):
	if not alive:
		return
#	control(delta)
	move_and_slide(velocity)
	if knocked_down:
		return
	control(delta)
#	move_and_slide(velocity)
	 
	
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#pass