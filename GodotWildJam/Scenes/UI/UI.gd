extends ViewportContainer

func _ready():
	$canvas/Menu/Center/VBox/Start.connect("pressed", self, "start_pressed")
	$canvas/Menu/Center/VBox/Quit.connect("pressed", self, "quit_pressed")

func menu_toggle():
	$canvas/Menu.visible = !$canvas/Menu.visible

func change_buttons():
	$canvas/Menu/Center/VBox/Start.visible = !$canvas/Menu/Center/VBox/Start.visible
	$canvas/Menu/Center/VBox/Resume.visible = !$canvas/Menu/Center/VBox/Resume.visible



func start_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene_to(load("res://Scenes/Levels/Test.tscn"))
	change_buttons()
	menu_toggle()
	

func quit_pressed():
	get_tree().quit()