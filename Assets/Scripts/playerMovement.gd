extends CharacterBody2D

@export var speed: int = 40
@export var tileSize: int = 16
@onready var animPlayer = $CharacterAnimation
var vector
var movement

var anim = "walk_down"
# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement_input()
	move_and_slide()
	
	if anim:	
		animPlayer.play(anim)


func movement_input():
	
	if Input.is_action_pressed("moveUp"):
		anim = "walk_up"
		velocity.y = -speed
		velocity.x = 0
	elif Input.is_action_pressed("moveDown"):
		anim = "walk_down"
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("moveLeft"):
		anim = "walk_left"
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("moveRight"):
		anim = "walk_right"
		velocity.x = speed
		velocity.y = 0
	else:
		velocity.x = 0
		velocity.y = 0
