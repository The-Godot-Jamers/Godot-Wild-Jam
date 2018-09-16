extends Camera2D

export var zoom_amt = Vector2(0.05, 0.05)
export var zoom_time = 0.2

func _input(event):
	if Input.is_action_just_pressed("zoom_out"):
		$Tween.interpolate_property(self,"zoom",zoom,zoom + zoom_amt, zoom_time,Tween.TRANS_QUAD,Tween.EASE_OUT_IN)
		$Tween.start()
	if Input.is_action_just_pressed("zoom_in"):
		$Tween.interpolate_property(self,"zoom",zoom,zoom - zoom_amt, zoom_time,Tween.TRANS_QUAD,Tween.EASE_OUT_IN)
		$Tween.start()
	