extends Node


@onready var player = Player.new()

func _ready():
	SaveLoad.loadGame()

@onready var isFirstStartGame = false
@onready var wonPokemon = false
@onready var isWalking = false

@onready var pokemonLevel = 10
