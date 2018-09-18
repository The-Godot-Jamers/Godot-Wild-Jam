extends Area2D

export var hit_force = 1
export var speed = 10

var pickable = true
var player_in_area = false
var velocity = Vector2()
var thrower #so we people dont throw stuff on their own heads

func _ready():
	add_to_group("THROW")
	connect("body_entered", self, "body_enter")
	connect("body_exited", self, "body_exit")
	rotation_degrees = rand_range(0,360)

func _physics_process(delta):
	if not pickable && (!velocity.x == 0 or !velocity.y == 0):
		position += velocity * delta * speed
		velocity -= velocity * delta * speed
		if abs(velocity.x) <= 0.5:
			velocity.x = 0
		if abs(velocity.y) <= 0.5:
			velocity.y = 0
		if velocity == Vector2(0,0):
			pickable = true


func body_enter(body):
	if not pickable && body != thrower:
		if not body.is_in_group("WALLS"):
			body.take_hit(hit_force)
			
		pickable = true
		velocity = Vector2(0,0)
	if body.is_in_group("PLAYER"):
		player_in_area = true

func body_exit(body):
	if body.is_in_group("PLAYER"):
		player_in_area = false

func get_tex():
	var tex = $Sprite.texture
	return tex
