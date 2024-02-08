extends Area2D

# The speed for the sprite movement animation
@export var speed: float = 0.7

# set the size of each tile on the tileSheet.
@export var tileSize: int = 16

# assign the tilemap to move on
@export var tileMap: TileMap

# assign the animation player that handles sprite animation
@export var animPlayer: AnimationPlayer

# assign the sprite, so its movement can be animated
@export var sprite: Sprite2D

# set defaults
var isMoving = false
var anim = "walk_down"

func _process(_delta):
	
	# play the currently "selected" animation
	if anim:	
		animPlayer.play(anim)
	
	# end script if the player is currently moving
	if isMoving:
		return
		
	# get player input
	movement_input()

func _physics_process(_delta):
	
	# end script if the player is standing still
	if not isMoving:
		return
		
	# let the script know that the sprite has caught up and movement to new tile is complete.
	if global_position == sprite.global_position:
		isMoving = false
		return
	
	# move the sprite from the previous tile toward the new tile.
	sprite.global_position = sprite.global_position.move_toward(global_position, speed)
	

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
	global_position = tileMap.map_to_local(targetTile)
	sprite.global_position = tileMap.map_to_local(currentTile)

