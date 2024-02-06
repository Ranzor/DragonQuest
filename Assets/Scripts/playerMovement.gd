extends Area2D

@export var speed: int = 40
@export var tileSize: int = 16
@onready var tileMap = $"../TileMap"
@onready var animPlayer = $CharacterAnimation
@onready var sprite = $PlayerSprite
var isMoving = false
var anim = "walk_down"
# Called when the node enters the scene tree for the first time.
func _ready():	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if anim:	
		animPlayer.play(anim)
	
	if isMoving:
		return
		
	movement_input()

func _physics_process(delta):
	if not isMoving:
		return
		
	if global_position == sprite.global_position:
		isMoving = false
		return
	
	sprite.global_position = sprite.global_position.move_toward(global_position, 0.7)
	


func movement_input():
	
	if Input.is_action_pressed("moveUp"):
		anim = "walk_up"
		move(Vector2.UP)
	elif Input.is_action_pressed("moveDown"):
		anim = "walk_down"
		move(Vector2.DOWN)
	elif Input.is_action_pressed("moveLeft"):
		anim = "walk_left"
		move(Vector2.LEFT)
	elif Input.is_action_pressed("moveRight"):
		anim = "walk_right"
		move(Vector2.RIGHT)
	else:
		pass

func move(direction: Vector2):
	# get current tile Vector2i
	var currentTile: Vector2i = tileMap.local_to_map(global_position)
	# get target tile Vector2i
	var targetTile: Vector2i = Vector2i(
		currentTile.x + direction.x,
		currentTile.y + direction.y
	)
	print("Current Tile:", currentTile, "Target Tile:", targetTile)
	# get custom data layer from the target tile
	var tileData: TileData = tileMap.get_cell_tile_data(0, targetTile)
	var walkableValue = tileData.get_custom_data("walkable")
	print("Walkable Value:", walkableValue, "Type:", typeof(walkableValue))
	if walkableValue is bool and walkableValue == false:
		return
	# move player
	isMoving = true
	
	global_position = tileMap.map_to_local(targetTile)
	sprite.global_position = tileMap.map_to_local(currentTile)

