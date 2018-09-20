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
export (int) var health = 30

var velocity = Vector2()
var can_throw = true
var alive = true #Death animation
var knocked_down = false #Knocked down animation

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

func do_something():
	if rand_range(0,100) < care_about_issue / 10:
		if care_about_issue > 70 && hot_headedness > 50 && rand_range(0,100) > 50:
			$talk.yell(self)
		else:
			$talk.talk(self)
		return
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
	
	
	velocity = move_and_slide(velocity)
	
	state_cur = state_nxt
	match state_cur:
		STATES.WANDER:
			_state_wander( delta )
		STATES.TARGET:
			_state_target( delta )
	
	
	if knocked_down:
		return
	#control(delta)

func take_hit(amt):
	health -= amt






enum STATES { WANDER, TARGET, HIT }
var state_cur = -1
var state_nxt = STATES.WANDER
const MAX_VELOCITY = 50
var target = null


func steering( target_pos ):
	var desired_velocity = ( target_pos - global_position ).normalized() * MAX_VELOCITY
	velocity += desired_velocity
	velocity = velocity.clamped( MAX_VELOCITY )


func _state_wander( delta ):
	# check for targets
	# look for player
	if _player_line_of_sight():
		# player is in sight, set it as target and go hunt
		target = Globals.player
		state_nxt = STATES.TARGET
	else:
		control( delta )

func _state_target( delta ):
	if target == null or target.get_ref() == null:
		# the target is gone
		state_nxt = STATES.WANDER
		return
	var distance_to_target = target.get_ref().global_position - global_position
	if distance_to_target.length() < 10:
		# reached target
		state_nxt = STATES.HIT
		return
	# steer torwards target
	steering( target.get_ref().global_position )
	pass



func _player_line_of_sight():
	if Globals.player == null or Globals.player.get_ref() == null:
		# no player
		return false
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray( \
			global_position, Globals.player.get_ref().global_position, \
			[], 1 + 8 )
	if result.collider == Globals.player.get_ref():
		return true
	return false