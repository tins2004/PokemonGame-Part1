extends Node


@onready var player = Player.new()

@onready var pokemon1
@onready var pokemon1CurrentHeart = 1

@onready var pokemon2
@onready var pokemon2ID = 0
@onready var pokemon2CurrentHeart = 1

@onready var pokemon3
@onready var pokemon3ID = 0
@onready var pokemon3CurrentHeart = 1


@onready var isFirstStartGame = false
@onready var endCombat = false
@onready var isWalking = false

@onready var volume = 0
@onready var fullScreen = false

func _ready():
	SaveLoad.loadGame()
	
	settingValue()

func settingValue():
	var master_bus = AudioServer.get_bus_index("Master")
	
	AudioServer.set_bus_volume_db(master_bus, volume)
	if volume == -10:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	
	if fullScreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func loadPokemon1(Level: int, Heart: int):
	pokemon1 = Picachu.new(Level)
	pokemon1CurrentHeart = Heart

func loadPokemon2(Level: int, Heart: int):
	if pokemon2ID == 0:
		pokemon2 = Picachu.new(Level)
	elif pokemon2ID == 1:
		pokemon2 = Fushigidane.new(Level)
	elif pokemon2ID == 2:
		pokemon2 = Hitotaghe.new(Level)
	elif pokemon2ID == 3:
		pokemon2 = Zenigame.new(Level)
	elif pokemon2ID == 4:
		pokemon2 = Arbo.new(Level)
	elif pokemon2ID == 5:
		pokemon2 = Dogars.new(Level)
	elif pokemon2ID == 6:
		pokemon2 = Isitsubute.new(Level)
	elif pokemon2ID == 7:
		pokemon2 = Iwark.new(Level)
	
	pokemon2CurrentHeart = Heart

func loadPokemon3(Level: int, Heart: int):
	if pokemon3ID == 0:
		pokemon3 = Picachu.new(Level)
	elif pokemon3ID == 1:
		pokemon3 = Fushigidane.new(Level)
	elif pokemon3ID == 2:
		pokemon3 = Hitotaghe.new(Level)
	elif pokemon3ID == 3:
		pokemon3 = Zenigame.new(Level)
	elif pokemon3ID == 4:
		pokemon3 = Arbo.new(Level)
	elif pokemon3ID == 5:
		pokemon3 = Dogars.new(Level)
	elif pokemon3ID == 6:
		pokemon3 = Isitsubute.new(Level)
	elif pokemon3ID == 7:
		pokemon3 = Iwark.new(Level)
	
	pokemon3CurrentHeart = Heart
