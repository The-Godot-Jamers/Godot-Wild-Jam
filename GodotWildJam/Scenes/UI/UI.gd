extends ViewportContainer

var inventory_selected = -1

func _ready():
	$canvas/Menu/Center/VBox/Start.connect("pressed", self, "start_pressed")
	$canvas/Menu/Center/VBox/Resume.connect("pressed", self, "resume_pressed")
	$canvas/Menu/Center/VBox/Quit.connect("pressed", self, "quit_pressed")
	$canvas/Inventory/margin/hbox/slot0.connect("pressed", self, "inventory_select",[0])
	$canvas/Inventory/margin/hbox/slot1.connect("pressed", self, "inventory_select",[1])
	$canvas/Inventory/margin/hbox/slot2.connect("pressed", self, "inventory_select",[2])

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
		var police_icon = $canvas/Overall/Police_margin/hbox.get_child(i)
		if i+1 <= lvl:
			police_icon.show()
		else:
			police_icon.hide()

func inventory_add(tex,slot):
	if slot == 0:
		$canvas/Inventory/margin/hbox/slot0.texture_normal = tex
		$canvas/Inventory/margin/hbox/slot0/highlight.texture = tex
		$canvas/Inventory/margin/hbox/slot0.show()
	if slot == 1:
		$canvas/Inventory/margin/hbox/slot1.texture_normal = tex
		$canvas/Inventory/margin/hbox/slot1/highlight.texture = tex
		$canvas/Inventory/margin/hbox/slot1.show()
	if slot == 2:
		$canvas/Inventory/margin/hbox/slot2.texture_normal = tex
		$canvas/Inventory/margin/hbox/slot2/highlight.texture = tex
		$canvas/Inventory/margin/hbox/slot2.show()

func inventory_resuffle(inventory):
	for i in 3:
		inventory_remove(i)
	for i in inventory.size():
		inventory_add(inventory[i].get_tex(), i)
	$canvas/Inventory/margin/hbox/slot0/highlight.hide()
	$canvas/Inventory/margin/hbox/slot1/highlight.hide()
	$canvas/Inventory/margin/hbox/slot2/highlight.hide()

func inventory_remove(slot):
	if slot == 0:
		$canvas/Inventory/margin/hbox/slot0.texture_normal = null
		$canvas/Inventory/margin/hbox/slot0/highlight.texture = null
		#$canvas/Inventory/margin/hbox/slot0.hide()
	if slot == 1:
		$canvas/Inventory/margin/hbox/slot1.texture_normal = null
		$canvas/Inventory/margin/hbox/slot1/highlight.texture = null
		#$canvas/Inventory/margin/hbox/slot1.hide()
	if slot == 2:
		$canvas/Inventory/margin/hbox/slot2.texture_normal = null
		$canvas/Inventory/margin/hbox/slot2/highlight.texture = null
		#$canvas/Inventory/margin/hbox/slot2.hide()
	inventory_selected = -1

func inventory_select(slot):
	$canvas/Inventory/margin/hbox/slot0/highlight.hide()
	$canvas/Inventory/margin/hbox/slot1/highlight.hide()
	$canvas/Inventory/margin/hbox/slot2/highlight.hide()

	if slot == 0:
		inventory_selected = 0
		$canvas/Inventory/margin/hbox/slot0/highlight.show()
	if slot == 1:
		inventory_selected = 1
		$canvas/Inventory/margin/hbox/slot1/highlight.show()
	if slot == 2:
		inventory_selected = 2
		$canvas/Inventory/margin/hbox/slot2/highlight.show()

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

func resume_pressed():
	get_tree().paused = false
	menu_toggle()
	
	



