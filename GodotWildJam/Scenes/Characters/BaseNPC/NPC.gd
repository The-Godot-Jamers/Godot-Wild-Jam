extends KinematicBody2D

signal health_changed
signal dead #for death status and death animations
signal knocked_down #knock down status and animation

#baselines for everyone unless chanced.
var hot_headedness = 0  #How likely to start acting violent
var care_about_issue = 20 #How much do they care about this particular issue
var police_interest = 0 #how much do you annoy the police

export (PackedScene) var Bullet # for Thrown Obejcts
export (int) var speed = 50
export (float) var rotation_speed #for character rotation
export (int) var health = 30
var free = 0

var velocity = Vector2()
var can_throw = true
var alive = true #Death animation
var knocked_down = false #Knocked down animation
var conga = null

var move_distance = 0
var direction = Vector2()

func _ready():
	$AnimatedSprite_Body.modulate = Globals.human_colors[randi() % Globals.human_colors.size()]
	$Head.modulate = Globals.human_colors[randi() % Globals.human_colors.size()]
	add_to_group("NPC")
	care_about_issue += rand_range(-10,10)
	#maybe some general variations and stuff
	$Timer.wait_time += rand_range(-0.2, 0.2)
	$Timer.connect("timeout",self,"do_something")

func conga(who):
	if who == self:
		return
	if Globals.conga_line.size() == 0: 
		conga = Globals.player.get_ref()
	else:
		conga = Globals.conga_line[Globals.conga_line.size() - 1]
	Globals.conga_line.append(self)
	#print(self)
	#print(conga)

func do_something():
	if not is_in_group("POLICE"):
		if rand_range(0,100) < care_about_issue && rand_range(0,100) > 90:
			if care_about_issue > 70 && hot_headedness > 50 && rand_range(0,100) > 70:
				$talk.yell(self)
			else:
				$talk.talk(self)
			return
		direction = Vector2(rand_range(-1,1), rand_range(-1,1))
		move_distance = rand_range(10,50)

func control(delta):
	#move_and_slide etc.
	if free > 0:
		free += 1
		return
	if conga != null && conga != self && $Timer.is_stopped():  
		if move_distance > 0:
			direction = Globals.player.get_ref().global_position - global_position
			#direction = conga.global_position - global_position
			look_at(position + direction.normalized())
			move_and_slide(direction.normalized() * speed)
			move_distance -= speed * delta
			return
	#print(direction)
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
	move_and_slide( velocity )
	
	if knocked_down:
		return
	control(delta)

func take_hit(amt):
	health -= amt






