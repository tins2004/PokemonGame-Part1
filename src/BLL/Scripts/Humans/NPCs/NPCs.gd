extends Node
class_name NPCs

var nameNPC: String = ""

func setName(Name: String):
	nameNPC = Name

func getName() -> String:
	return nameNPC


func _on_area_2d_body_entered(body):
	if (body.name == "Player"):
		$CanvasLayer/Hoimau.visible = true


func _on_area_2d_body_exited(body):
	if (body.name == "Player"):
		$CanvasLayer/Hoimau.visible = false


func _on_no_pressed():
	$CanvasLayer/Hoimau.visible = false


func _on_yes_pressed():
	Global.player.deduction(300)
	Global.pokemon1CurrentHeart += 100
	
	if Global.player.getNumberPokemon() >= 2:
		Global.pokemon2CurrentHeart += 100
		if Global.player.getNumberPokemon() == 3:
			Global.pokemon3CurrentHeart += 100
	
	$CanvasLayer/Hoimau.visible = false
