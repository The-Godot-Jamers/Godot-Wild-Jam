extends "res://Scenes/Characters/BaseNPC/NPC.gd"

#They should have special base behaviors as a class.



func _ready():
	care_about_issue = 0
	$AnimatedSprite_Body.modulate = Globals.police_colors[randi() % Globals.police_colors.size()]
	$Head.modulate = Globals.police_colors[randi() % Globals.police_colors.size()]





func _physics_process(delta):
	if not alive:
		return
	
	
	# look towards where we're going
	look_at( position + velocity )
	
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
	# if target is gone
	if target == null or target.get_ref() == null:
		# the target is gone
		state_nxt = STATES.WANDER
		return
	if target == Globals.player:
		if not _player_line_of_sight():
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