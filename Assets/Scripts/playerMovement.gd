extends Area2D

# The speed for the sprite movement animation
@export var speed: float = 0.7

# set the size of each tile on the tileSheet.
@export var tileSize: int = 16

# assign the tilemap to move on
var tileMap: TileMap

# assign the animation player that handles sprite animation
@export var animPlayer: AnimationPlayer

# assign the sprite, so its movement can be animated
@export var sprite: Sprite2D

@export var col: CollisionShape2D

@export_enum("walk_down", "walk_up", "walk_left", "walk_right") var anim: String

var pos = 5
var timer = 0.5

# set defaults
var isMoving = false

func _ready():
	GetTileMap()
	SelectSpawn()
	anim = Character.spawnAnim
	

func _process(delta):
	
	# play the currently "selected" animation
	if anim:	
		animPlayer.play(anim)
	
	# end script if the player is currently moving
	if isMoving:
		return
		
	# get player input
	if Character.canMove:
		movement_input()
	
	if not Character.canMove:
		HandleTransition(delta)

func _physics_process(_delta):
	
	# end script if the player is standing still
	if not isMoving:
		return
		
	# let the script know that the sprite has caught up and movement to new tile is complete.
	if global_position == sprite.global_position:
		print(global_position)
		isMoving = false
		return
	
	# move the sprite from the previous tile toward the new tile.
	sprite.global_position = sprite.global_position.move_toward(global_position, speed)
	col.global_position = col.global_position.move_toward(global_position, speed)
	

# Handle player input
func movement_input():
	
	# When a direction key is pressed, assign the appropriate animation and call the movement function with the apropriate direction
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
		
# Handles the actual movement.
func move(direction: Vector2):
	
	# Get the global position of the tile the player is standing on
	var currentTile: Vector2i = tileMap.local_to_map(global_position)
	
	# Get the global position of the tile the player is attempting to move to.
	@warning_ignore("narrowing_conversion")
	var targetTile: Vector2i = Vector2i(
		currentTile.x + direction.x,
		currentTile.y + direction.y
	)
	
	# Get custom data layer from the target tile - this is set in the tileset, allows you to give custom attributes to a tile, in this case determine if you can walk on a tile or not.
	var tileData: TileData = tileMap.get_cell_tile_data(0, targetTile)
	
	# return if it is not a tile you can walk on
	if tileData.get_custom_data("walkable") == false:
		return
	
	# move player, the sprite stays behind to be animated
	isMoving = true	
	print(Character.canTravel)
	global_position = tileMap.map_to_local(targetTile)
	sprite.global_position = tileMap.map_to_local(currentTile)
	col.global_position = tileMap.map_to_local(currentTile)
	Character.canTravel = true
	
func GetTileMap() -> void:
	for child in get_tree().root.get_children():		
		for grandchild in child.get_children():
			if grandchild is TileMap:
				print(grandchild)
				tileMap = grandchild


func SelectSpawn() -> void:
	print("curLoc: " + Character.curLoc)
	print("prevLoc: " + Character.prevLoc)
	
	match Character.curLoc:		
		"tangentel":
			if Character.prevLoc == "tangentelCastle":
				global_position = Vector2(136,120)				
			elif Character.prevLoc == "overworld":
				global_position = Vector2(168, 472)
			pass
		"tangentelCastle":
			if Character.prevLoc == "tangentel":
				global_position = Vector2(248,232)
				pass
			else:
				pass
		"overworld":
			if Character.prevLoc == "tangentel":
				global_position = Vector2(184, 216)
			elif Character.prevLoc == "brecconary":
				global_position = Vector2(264,184)				
			else:
				pass
		"brecconary":
			if Character.prevLoc == "overworld":
				global_position = Vector2(8,232)
			else:
				pass
		_:
			global_position = Vector2(200,168)
		
func HandleTransition(delta):
	timer -= delta
	if timer <= 0:
		Character.canMove = true
		timer = 0.5
	
