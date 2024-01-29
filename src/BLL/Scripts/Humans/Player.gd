extends Node
class_name Player

var namePlayer: String = ""
var sexPlayer: bool = true #true: Male; false: Female

func getName() -> String:
	return namePlayer

func setName(value: String):
	namePlayer = value

func getSex() -> bool:
	return sexPlayer

func setSex(value: bool):
	sexPlayer = value
