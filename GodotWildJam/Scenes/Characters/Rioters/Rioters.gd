extends "res://Scenes/Characters/BaseNPC/NPC.gd"

#They should have special base behaviors as a class.

func _ready():
	hot_headedness += rand_range(+15, +30)
	$Head.texture = load(Globals.heads[randi() % Globals.heads.size()])
