extends "res://Scenes/Characters/BaseNPC/NPC.gd"


func control(delta):
	
	#$Player/AnimatedSprite.play("walk")
	$Head.look_at(get_global_mouse_position())
	$Body.look_at(get_global_mouse_position())
	var m_speed = speed*10

	if Input.is_action_pressed('Right'):
		velocity = Vector2(m_speed,0)
	if Input.is_action_pressed('Left'):
		velocity = Vector2(-m_speed,0)
	if Input.is_action_pressed('Up'):
		velocity = Vector2(0,m_speed)
	if Input.is_action_pressed('Down'):
		velocity = Vector2(0,-m_speed) 
	if velocity ==  Vector2(0,0): 
		$Body.play("idle")
	else:
		move_and_slide (velocity,Vector2(0,0))
		$Body.play("walk")
	velocity = Vector2(0,0)

func _input(event):
	
	if Input.is_action_just_pressed('ui_accept'):
		
# var b = "textvar"

#func _ready():
	#$Player/AnimatedSprite.play("walk")
	# Called when the node is added to the scene for the first time.
	# Initialization here
#	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


