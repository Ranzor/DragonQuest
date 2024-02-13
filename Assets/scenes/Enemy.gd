extends Sprite2D

var x = 0

var slime = 0
var redSlime = 1
var ghost = 3

func _ready():
	x = randi_range(0,3)
	match x:
		0:
			set_frame(slime)
		1:
			set_frame(redSlime)
		2:
			set_frame(ghost)
