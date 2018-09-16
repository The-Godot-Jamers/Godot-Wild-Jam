extends Camera2D

export var zoom_amt = Vector2(0.5, 0.5)
export var zoom_time = 0.2

func _input(event):
	if not $Tween.is_processing():
		if Input.is_action_just_pressed("zoom_out"):
			$Tween.interpolate_property(self,"zoom",zoom,zoom + zoom_amt, zoom_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			$Tween.start()
		if Input.is_action_just_pressed("zoom_in"):
			$Tween.interpolate_property(self,"zoom",zoom,zoom - zoom_amt, zoom_time,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
			$Tween.start()
	