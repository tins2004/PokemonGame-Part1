extends Node
class_name NPCs

var nameNPC: String = ""

func setName(Name: String):
	nameNPC = Name

func getName() -> String:
	return nameNPC




func _on_area_2d_body_entered(body):
	if (body.name == "Player"):
		print("Cái ccc")
