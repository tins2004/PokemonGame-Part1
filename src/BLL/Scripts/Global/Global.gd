extends Node


@onready var player = Player.new()

func _ready():
	SaveLoad.loadGame()

@onready var isFirstStartGame = false
