extends Node2D

# Create a dictionary of all your levels that you want to be able to change to.
@export var Scenes : Dictionary = {}
var currentScene : String = ""


func AddScene(sceneName : String, scenePath : String) -> void:
	Scenes[sceneName] = scenePath
	
func RemoveScene(sceneName : String) -> void:
	Scenes.erase(sceneName)

# call this from wherever to change to a specified scene by passing the dictionary key of the scene.	
func SwitchScene(sceneName : String) -> void:
	# using call_deferred() to prevent physics issues
	get_tree().call_deferred("change_scene_to_file", Scenes[sceneName])
	
func RestartScene() -> void:
	get_tree().reload_current_scene()
	
func QuitGame() -> void:
	get_tree().quit()	

func GetSceneCount() -> int:
	return Scenes.size()
	
func getCurrentSceneName() -> String:
	return currentScene	
	
func _ready() -> void:
	var mainScene : StringName = ProjectSettings.get_setting("application/run/main_scene")
	currentScene = Scenes.find_key(mainScene)
