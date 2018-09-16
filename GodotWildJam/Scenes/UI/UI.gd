extends ViewportContainer

func _ready():
	$canvas/Menu/Center/VBox/Start.connect("pressed", self, "start_pressed")
	$canvas/Menu/Center/VBox/Quit.connect("pressed", self, "quit_pressed")

func menu_toggle():
	$canvas/Menu.visible = !$canvas/Menu.visible

func change_buttons():
	$canvas/Menu/Center/VBox/Start.visible = !$canvas/Menu/Center/VBox/Start.visible
	$canvas/Menu/Center/VBox/Resume.visible = !$canvas/Menu/Center/VBox/Resume.visible

func riot_lvl_update(lvl):
	for i in $canvas/Overall/Molotov_margin/hbox.get_child_count():
		var riot_icon = $canvas/Overall/Molotov_margin/hbox.get_child(i)
		if i+1 <= lvl:
			riot_icon.show()
		else:
			riot_icon.hide()

func police_lvl_update(lvl):
	for i in $canvas/Overall/Police_margin/hbox.get_child_count():
		var riot_icon = $canvas/Overall/Police_margin/hbox.get_child(i)
		if i+1 <= lvl:
			riot_icon.show()
		else:
			riot_icon.hide()

func start_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene_to(load("res://Scenes/Levels/Test.tscn"))
	change_buttons()
	menu_toggle()
	$canvas/Overall.show()
	riot_lvl_update(Globals.riot_lvl)
	police_lvl_update(Globals.police_lvl)

func quit_pressed():
	get_tree().quit()