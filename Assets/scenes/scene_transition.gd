extends Area2D

@export_enum("tangentel", "tangentelCastle", "brecconary", "overworld") var originArea: String
@export_enum("tangentel", "tangentelCastle", "brecconary", "overworld") var transitionArea: String
@export_enum("walk_up", "walk_down", "walk_left", "walk_right") var spawnAnimation: String

func _on_area_entered(_area):
	print(transitionArea)
	if Character.canTravel:
		Character.prevLoc = originArea
		Character.curLoc = transitionArea
		Character.spawnAnim = spawnAnimation
		Character.canTravel = false
		Character.canMove = false
		HandleSwitching(transitionArea)	
	pass # Replace with function body.

func HandleSwitching(scene):
	await get_tree().create_timer(0.5).timeout
	GameManager.SwitchScene(scene)
