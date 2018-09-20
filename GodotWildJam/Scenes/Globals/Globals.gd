extends Node

var riot_lvl = 0 setget riot_lvl_set, riot_get
var police_lvl = 0 setget police_lvl_set, police_get

var colors = ["#472D3C","#5E3643","#7A444A","#A05B53","#BF7958","#EEA160","#FFFDAF","#B6D53C",
				"#71AA34","#397B44","#3C5956","#302C2E","#5A5353","#7D7071","#A0938E","#CFC6B8",
				"#DFF6F5","#8AEBF1","#00FAAC","#3978A8","#394778","#39314B","#564064","#302387",
				"#FFAEB6","#F4B41B","#F47E1B","#E6482E","#A93B3B","#827094","#4F546B"]

var human_colors = ["#472D3C","#5E3643","#7A444A","#A05B53","#BF7958","#EEA160","#FFFDAF"]
var police_colors = ["#3978A8","#394778","#302387","#4F546B"]

var heads = ["res://Art/Characters and Animations/Rude-Pixels/head-01.png","res://Art/Characters and Animations/Rude-Pixels/head-02.png",
			"res://Art/Characters and Animations/Rude-Pixels/head-03.png","res://Art/Characters and Animations/Rude-Pixels/head-04.png",
			"res://Art/Characters and Animations/Rude-Pixels/head-05.png","res://Art/Characters and Animations/Rude-Pixels/head-06.png",
			"res://Art/Characters and Animations/Rude-Pixels/head-07.png","res://Art/Characters and Animations/Rude-Pixels/head-08.png",
			"res://Art/Characters and Animations/Rude-Pixels/head-09.png","res://Art/Characters and Animations/Rude-Pixels/head-10.png"]

var conga_line = []

var player = null

func _ready():
	randomize()

func riot_lvl_set(lvl):
	riot_lvl = lvl
	UI.riot_lvl_update(riot_lvl)

func police_lvl_set(lvl):
	police_lvl = lvl
	UI.police_lvl_update(police_lvl)

func riot_get():
	return riot_lvl
func police_get():
	return police_lvl

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		UI.menu_toggle()
		get_tree().paused = !get_tree().paused
	if Input.is_action_just_pressed("ui_focus_next"):
		get_tree().reload_current_scene()
