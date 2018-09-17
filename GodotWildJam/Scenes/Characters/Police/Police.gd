extends "res://Scenes/Characters/BaseNPC/NPC.gd"

#They should have special base behaviors as a class.

func _ready():
	care_about_issue = 0
	$AnimatedSprite_Body.modulate = Globals.police_colors[randi() % Globals.police_colors.size()]
	$Head.modulate = Globals.police_colors[randi() % Globals.police_colors.size()]

