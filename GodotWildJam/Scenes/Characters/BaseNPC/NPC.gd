extends KinematicBody2D

signal health_changed
signal dead #for death status and death animations
signal knocked_down #knock down status and animation




export (PackedScene) var Bullet # for Thrown Obejcts
export (int) var speed 
export (float) var rotation_speed #for character rotation 


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


