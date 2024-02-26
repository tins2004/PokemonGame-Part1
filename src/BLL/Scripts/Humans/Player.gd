extends Node
class_name Player

var namePlayer: String = ""
var sexPlayer: bool = true #true: Male; false: Female
var numberPokemon: int = 1
var money: int = 0
var pokeBall: int = 0

func getName() -> String:
	return namePlayer

func setName(value: String):
	namePlayer = value

func getSex() -> bool:
	return sexPlayer

func setSex(value: bool):
	sexPlayer = value

func getNumberPokemon() -> int:
	return numberPokemon

func setNumberPokemon(value: int):
	numberPokemon = value

func getMoney() -> int:
	return money

func setMoney(value: int):
	money = value

func receiveMoney(value: int):
	money += value

func deduction(value: int):
	money -= value

func getPokeBall() -> int:
	return pokeBall

func setPokeBall(value: int):
	pokeBall = value

func increasePokeBall(value: int):
	pokeBall -= value

func reducePokeBall(value: int):
	pokeBall -= value
