extends Area2D

export var hit_force = 1
export var speed = 10

var pickable = true
var player_in_area = false

func _ready():
	add_to_group("THROW")
	connect("body_entered", self, "body_enter")
	connect("body_exited", self, "body_exit")

func body_enter(body):
	if body.is_in_group("PLAYER"):
		player_in_area = true

func body_exit(body):
	if body.is_in_group("PLAYER"):
		player_in_area = false

func get_tex():
	var tex = $Sprite.texture
	return tex
