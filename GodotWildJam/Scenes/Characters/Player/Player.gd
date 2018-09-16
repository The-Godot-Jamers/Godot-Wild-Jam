extends KinematicBody2D #player earns its place as independent of NPCs

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
	#player setup
	pass

func _physics_process(delta):
	if not alive:
		return
	move_and_slide(velocity)
	if knocked_down:
		return
	control(delta)

func control(delta):
	
	#$Player/AnimatedSprite.play("walk")
	$Head.look_at(get_global_mouse_position())
	$Body.look_at(get_global_mouse_position())
	var m_speed = speed * 10

	if Input.is_action_pressed('Right'):
		velocity += Vector2(m_speed, 0)
	if Input.is_action_pressed('Left'):
		velocity += Vector2(-m_speed, 0)
	if Input.is_action_pressed('Up'):
		velocity += Vector2(0, -m_speed)
	if Input.is_action_pressed('Down'):
		velocity += Vector2(0, m_speed) 
	if velocity ==  Vector2(0, 0): 
		$Body.play("idle")
	else:
		move_and_slide (velocity,Vector2(0, 0))
		$Body.play("walk")
	velocity = Vector2(0, 0)

func _input(event):
	if Input.is_action_just_pressed('ui_accept'):
		Globals.riot_lvl += 1
		Globals.police_lvl += 1


