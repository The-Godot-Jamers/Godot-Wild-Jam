extends Node2D

export var people_count = 10
export var item_count = 10
export var police_count = 10
var gas_guy = preload("res://Scenes/Characters/Police/GasUnits/GasGuy.tscn")
var rude = preload("res://Scenes/Characters/Rioters/Rude/Rude.tscn")
var brick = preload("res://Scenes/Items/Brick.tscn")
var bottle = preload("res://Scenes/Items/Bottle.tscn")


func _ready():
	#adding people
	for i in people_count:
		var inst = rude.instance()
		inst.position = Vector2(rand_range(20,1004),rand_range(20,580))
		add_child(inst)
	for i in police_count:
		var inst = gas_guy.instance()
		inst.position = Vector2(rand_range(20,1004),rand_range(20,580))
		add_child(inst)
#adding stuff is bit different
	for i in item_count:
		var inst = brick.instance()
		inst.position = Vector2(rand_range(20,1004),rand_range(20,580))
		$ItemContainer.add_child(inst)
		inst = bottle.instance()
		inst.position = Vector2(rand_range(20,1004),rand_range(20,580))
		$ItemContainer.add_child(inst)
func _process(delta):
	var npc = get_tree().get_nodes_in_group("NPC")
	var care_lvl = 0
	var hot_lvl = 0
	for i in npc:
		care_lvl += i.care_about_issue
		hot_lvl += i.hot_headedness
		

	Globals.riot_lvl_set( hot_lvl / npc.size() / 20 )
	Globals.police_lvl_set( care_lvl / npc.size() / 20 )
