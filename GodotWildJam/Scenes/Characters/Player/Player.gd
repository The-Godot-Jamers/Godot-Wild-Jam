extends "res://Scenes/Characters/BaseNPC/NPC.gd"

func control(delta):
	
	#$Player/AnimatedSprite.play("walk")
	$Head.look_at(get_global_mouse_position())
	var rot_dir =0
	if Input.is_action_pressed('Right'):
		rot_dir += 1
	if Input.is_action_pressed('Left'):
		rot_dir -= 1
	rotation += rotation_speed *rot_dir *delta
	if Input.is_action_pressed('Forward'):
		$Head/AnimatedSprite.play("walk")
		velocity=Vector2(speed,0).rotated(rotation)
		
	if Input.is_action_pressed('Back'):
		velocity=Vector2(-speed/2,0).rotated(rotation)  



# class member variables go here, for example:
# var a = 2
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


