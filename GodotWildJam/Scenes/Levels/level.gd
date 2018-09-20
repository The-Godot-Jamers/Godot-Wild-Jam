extends Node2D

export var people_count = 100 # this is double as men + women
export var item_count = 30
export var police_count = 30
var gas_guy = preload("res://Scenes/Characters/Police/GasUnits/GasGuy.tscn")
var police = preload("res://Scenes/Characters/Police/NightStick/NightStick.tscn")
var rusher = preload("res://Scenes/Characters/Police/Cop_Rusher/Cop_Rusher.tscn")
var rude = preload("res://Scenes/Characters/Rioters/Rude/Rude.tscn")
var man = preload("res://Scenes/Characters/Rioters/man/man.tscn")
var woman = preload("res://Scenes/Characters/Rioters/woman/woman.tscn")
var brick = preload("res://Scenes/Items/Brick.tscn")
var bottle = preload("res://Scenes/Items/Bottle.tscn")


func _ready():
	UI.change_buttons()
	#adding people
	for i in people_count:
		var inst = man.instance()
		inst.position = Vector2(rand_range(20,1904),rand_range(20,1050))
		add_child(inst)
	for i in people_count:
		var inst = woman.instance()
		inst.position = Vector2(rand_range(20,1904),rand_range(20,1050))
		add_child(inst)
	for i in police_count:
		var inst
		if rand_range(0, 1) > 0.8:
			inst = rusher.instance()
		else:
			inst = police.instance()
		inst.position = Vector2(rand_range(20,1904),rand_range(20,1050))
		add_child(inst)
#adding stuff is bit different
#	for i in item_count:
#		var inst = brick.instance()
#		inst.position = Vector2(rand_range(20,1004),rand_range(20,580))
#		$ItemContainer.add_child(inst)
#		inst = bottle.instance()
#		inst.position = Vector2(rand_range(20,1004),rand_range(20,580))
#		$ItemContainer.add_child(inst)
#	print(get_child_count())
func _process(delta):
	var npc = get_tree().get_nodes_in_group("NPC")
	var care_lvl = 0
	var hot_lvl = 0
	for i in npc:
		care_lvl += i.care_about_issue
		hot_lvl += i.hot_headedness
		
	Globals.riot_lvl_set( hot_lvl / npc.size() / 20 )
	Globals.police_lvl_set( care_lvl / npc.size() / 20 )

func player_dead():
	$AnimationPlayer.play("player_dead")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "player_dead":
		get_tree().change_scene_to(load("res://Scenes/splash_screen/splash_screen.tscn"))
	UI.menu_toggle()
	UI.change_buttons()
