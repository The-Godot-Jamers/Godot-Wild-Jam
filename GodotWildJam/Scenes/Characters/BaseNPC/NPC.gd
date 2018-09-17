extends KinematicBody2D

signal health_changed
signal dead #for death status and death animations
signal knocked_down #knock down status and animation

#baselines for everyone unless chanced.
var hot_headedness = 0  #How likely to start acting violent
var care_about_issue = 50 #How much do they care about this particular issue
var police_interest = 0 #how much do you annoy the police

export (PackedScene) var Bullet # for Thrown Obejcts
export (int) var speed = 50
export (float) var rotation_speed #for character rotation
export (int) var health

var velocity = Vector2()
var can_throw = true
var alive = true #Death animation
var knocked_down = false #Knocked down animation

var move_distance = 0
var direction = Vector2()

func _ready():
	#maybe some general variations and stuff
	$Timer.wait_time += rand_range(-0.2, 0.2)
	$Timer.connect("timeout",self,"do_something")

func do_something():
	direction = Vector2(rand_range(-1,1), rand_range(-1,1))
	move_distance = rand_range(10,50)

func control(delta):
	#move_and_slide etc.
	if alive && !knocked_down && $Timer.is_stopped():
		if move_distance > 0:
			$AnimatedSprite_Body.play("walk")
			look_at(position + direction.normalized())
			move_and_slide(direction.normalized() * speed)
			move_distance -= speed * delta
			return
		$Timer.start()
		$AnimatedSprite_Body.play("idle")

func _physics_process(delta):
	if not alive:
		return
	move_and_slide(velocity)
	if knocked_down:
		return
	control(delta)


