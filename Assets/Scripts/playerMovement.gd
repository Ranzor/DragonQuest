extends Node2D

var speed = 40
var anim = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("moveUp"):
		anim = "walk_up"
		position.y -= speed * delta
	elif Input.is_action_pressed("moveDown"):
		anim = "walk_down"
		position.y += speed * delta
	elif Input.is_action_pressed("moveLeft"):
		anim = "walk_left"
		position.x -= speed * delta
	elif Input.is_action_pressed("moveRight"):
		anim = "walk_right"
		position.x += speed * delta
	
	if anim:	
		$CharacterAnimation.play(anim)
