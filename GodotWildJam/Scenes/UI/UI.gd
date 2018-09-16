extends Viewport

func _ready():
	print("hello")

func menu_toggle():
	$Menu.visible = !$Menu.visible

func _input(event):
	print("event")
	if Input.is_action_just_pressed("Interact"):
		print("t")
		menu_toggle()