extends KinematicBody2D

signal health_changed
signal dead #for death status and death animations
signal knocked_down #knock down status and animation

#baselines for everyone unless chanced.
var hot_headedness = 0  #How likely to start acting violent
var care_about_issue = 50 #How much do they care about this particular issue
var police_interest = 0 #how much do you annoy the police

export (PackedScene) var Bullet # for Thrown Obejcts
export (int) var speed 
export (float) var rotation_speed #for character rotation
export (int) var health

var velocity = Vector2()
var can_throw = true
var alive = true #Death animation
var knocked_down = false #Knocked down animation

func _ready():
	#maybe some general variations and stuff
	pass

func control(delta):
	#move_and_slide etc.
	pass

func _physics_process(delta):
	if not alive:
		return
	move_and_slide(velocity)
	if knocked_down:
		return
	control(delta)


