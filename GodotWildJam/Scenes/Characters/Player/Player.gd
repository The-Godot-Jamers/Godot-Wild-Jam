extends KinematicBody2D #player earns its place as independent of NPCs

signal health_changed
signal dead #for death status and death animations
signal knocked_down #knock down status and animation

#baselines for everyone unless chanced.
var hot_headedness = 0  #How likely to start acting violent
var care_about_issue = 50 #How much do they care about this particular issue
var police_interest = 0 #how much do you annoy the police

export (PackedScene) var Bullet # for Thrown Obejcts
export (int) var speed = 10
export (float) var rotation_speed #for character rotation
export (int) var health

var velocity = Vector2()
var can_throw = true
var alive = true #Death animation
var knocked_down = false #Knocked down animation

var throw_speed = 50

var inventory = []



func _ready():
	#player setup
	Globals.player = weakref( self )
	pass

func _physics_process(delta):
	#1-3 change to 0-2 because computer language
	if Input.is_action_just_pressed("1"):
		UI.inventory_select(0)
	if Input.is_action_just_pressed("2"):
		UI.inventory_select(1)
	if Input.is_action_just_pressed("3"):
		UI.inventory_select(2)
	if not alive:
		return
	move_and_slide(velocity)
	if knocked_down:
		return
	control(delta)

func control(delta):
	
	#$Player/AnimatedSprite.play("walk")
	$Head.look_at(get_global_mouse_position()) 
	#$Body.look_at(get_global_mouse_position())
	
	#$Body.rotation_degrees += 90
	$Head.rotation_degrees += 90
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
		$Body.look_at( position + velocity )
		$Body.rotation_degrees += 90
		$Body.play("walk")
	velocity = Vector2(0, 0)
	if Input.is_action_just_pressed("Interact"):
		$talk.talk(self)
	if Input.is_action_just_pressed("Interact2"):
		$talk.yell(self)
	if Input.is_action_just_pressed("pickup"):
		if (inventory.size()) < 3:
			var pickups = get_tree().get_nodes_in_group("THROW")
			for i in pickups:
				if i.player_in_area && i.pickable:
					UI.inventory_add(i.get_tex(),inventory.size())
					inventory.append(i)
					i.hide()
					i.pickable = false
					
	if Input.is_action_just_pressed("attack_push_throw"):
		if UI.inventory_selected > -1 && UI.inventory_selected < inventory.size():
			throw()

func throw():
		var inst = inventory[UI.inventory_selected]
		inventory.remove(UI.inventory_selected)
		inst.position = position
		inst.show()
		var direction = (position - get_global_mouse_position()).normalized()
		inst.rotation = direction.angle() -deg2rad(180)
		inst.velocity = -direction * throw_speed
		inst.thrower = self
		#UI.inventory_remove(UI.inventory_selected)
		if inventory.size() > -1:
			UI.inventory_resuffle(inventory)

func take_hit(amt):
	health -= amt


