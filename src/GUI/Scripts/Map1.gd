extends Node2D

func _ready():
	if Global.inMap == 1:
		$Player.position = Vector2(2142, 896)
	
	Global.inMap = 0

func _on_next_map_body_entered(body):
	if(body.name == "Player"):
		SaveLoad.saveGame()
		SaveLoad.loadGame()
		get_tree().change_scene_to_file("res://src/GUI/Scenes/Maps/Map2.tscn")
