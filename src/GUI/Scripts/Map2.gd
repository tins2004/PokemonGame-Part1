extends Node2D

func _ready():
	Global.inMap = 1

func _on_back_map_body_entered(body):
	if(body.name == "Player"):
		SaveLoad.saveGame()
		SaveLoad.loadGame()
		get_tree().change_scene_to_file("res://src/GUI/Scenes/Maps/Map1.tscn")
