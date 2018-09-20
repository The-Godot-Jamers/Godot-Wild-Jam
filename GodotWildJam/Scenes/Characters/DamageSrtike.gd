#from https://www.youtube.com/watch?v=JBczf8qt04c&t=6s
extends Area2D

signal attack_finished 

onready var animation_player= $AnimationPlayer

enum STATES {IDLE, ATTACK}

var curent_state =IDLE

export(int) var damage =1

func _ready():
	set_physics_process(false)
    
	
func attack  ():
	_change_state(ATTACK)
	
func _change_state(new_state):
	current_state = new_state
	
	match current_state:
		IDLE:
			set_physics_process(false)
		ATTACK:
			set_physics_process(true)
			animation_player.play("Hit_Lands")
	
	
func _physics_process(delta):
	var overlapping_bodies = get_overlapping_bodies()
	if not overlapping_bodies:
		return
		
	for body in overlapping_bodies:
		if not body.is_in_group("characters"):
			return
		if is_owner(body):
			return
		body.take_damage(damage)
		$HitLands.play()
	set_physics_process(false)
	
	
func is_owner(node):
	return node.strike_path == get_path()
	
func _on_AnimationPlayer_animation_finished ( name ):
	if name == "attack":
		_change_state (IDLE)
		emit_signal ("attack_finished") 
	



func _on_Area2DDamageStrike_attack_finished():
	pass # replace with function body
