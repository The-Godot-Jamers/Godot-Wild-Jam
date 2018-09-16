extends Sprite
var tex = get_texture()
export var size = Vector2(1024, 600)
var offs = Vector2()

func add_stuff(place, tex, offs = 0):
	tex.add_piece(place - offs, tex)
	update()

