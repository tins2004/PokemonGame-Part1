extends CanvasLayer

var optionMenu = 0 #0: Hành trang, 1: Pokemons, 2: Bản đồ, 3: Hướng dẫn, 4: Cài dặt, 5: Nạp tiền
var isClose = false

@onready var master_bus = AudioServer.get_bus_index("Master")

var imgPokemon0 = preload("res://img/Pokemons/8.jpg")
var imgPokemon1 = preload("res://img/Pokemons/9.jpg")
var imgPokemon2 = preload("res://img/Pokemons/10.jpg")
var imgPokemon3 = preload("res://img/Pokemons/11.jpg")
var imgPokemon4 = preload("res://img/Pokemons/12.jpg")
var imgPokemon5 = preload("res://img/Pokemons/13.jpg")
var imgPokemon6 = preload("res://img/Pokemons/14.jpg")
var imgPokemon7 = preload("res://img/Pokemons/15.jpg")

func _ready():
	$CaiDatMenu/VolumeSlider.set_value_no_signal(Global.volume)
	$CaiDatMenu/FullScreenToggled.button_pressed = Global.fullScreen


func _process(delta):
	if Input.is_physical_key_pressed(KEY_Q):
		isClose = true
	elif Input.is_physical_key_pressed(KEY_Z):
		optionMenu = 0
	elif Input.is_physical_key_pressed(KEY_X):
		optionMenu = 1
	elif Input.is_physical_key_pressed(KEY_C):
		optionMenu = 2
	elif Input.is_physical_key_pressed(KEY_A):
		optionMenu = 3
	elif Input.is_physical_key_pressed(KEY_S):
		optionMenu = 4
	
	if isClose:
		queue_free()
	
	moneySet()
	pokeBallSet()
	checkMenu()
	pokemonInfoSet(Global.player.getNumberPokemon())
 
func checkMenu():
	if optionMenu == 0:
		$HanhTrangMenu.visible = true
		$PokemonsMenu.visible = false
		$BanDoMenu.visible = false
		$HuongDanMenu.visible = false
		$CaiDatMenu.visible = false
		$NapTienMenu.visible = false
	elif optionMenu == 1:
		$HanhTrangMenu.visible = false
		$PokemonsMenu.visible = true
		$BanDoMenu.visible = false
		$HuongDanMenu.visible = false
		$CaiDatMenu.visible = false
		$NapTienMenu.visible = false
	elif optionMenu == 2:
		$HanhTrangMenu.visible = false
		$PokemonsMenu.visible = false
		$BanDoMenu.visible = true
		$HuongDanMenu.visible = false
		$CaiDatMenu.visible = false
		$NapTienMenu.visible = false
	elif optionMenu == 3:
		$HanhTrangMenu.visible = false
		$PokemonsMenu.visible = false
		$BanDoMenu.visible = false
		$HuongDanMenu.visible = true
		$CaiDatMenu.visible = false
		$NapTienMenu.visible = false
	elif optionMenu == 4:
		$HanhTrangMenu.visible = false
		$PokemonsMenu.visible = false
		$BanDoMenu.visible = false
		$HuongDanMenu.visible = false
		$CaiDatMenu.visible = true
		$NapTienMenu.visible = false
	elif optionMenu == 5:
		$HanhTrangMenu.visible = false
		$PokemonsMenu.visible = false
		$BanDoMenu.visible = false
		$HuongDanMenu.visible = false
		$CaiDatMenu.visible = false
		$NapTienMenu.visible = true

func _on_dong_button_pressed():
	isClose = true

func _on_hanh_trang_button_pressed():
	optionMenu = 0

func _on_pokemons_button_pressed():
	optionMenu = 1

func _on_ban_do_button_pressed():
	optionMenu = 2

func _on_huong_dan_button_pressed():
	optionMenu = 3

func _on_cai_dat_button_pressed():
	optionMenu = 4

func _on_nạp_tiền_pressed():
	optionMenu = 5

func moneySet():
	$Xu/Label.text = "Xu: " + str(Global.player.getMoney())

func pokeBallSet():
	$HanhTrangMenu/Slot1/Count.text = "Số lượng: " + str(Global.player.getPokeBall())

#Pokemons Menu
func pokemonInfoSet(numberPokemon: int):
	if numberPokemon == 1:
		$PokemonsMenu/Pokemon2.visible = false
		$PokemonsMenu/Pokemon3.visible = false
		infoPokemon1()
	elif numberPokemon == 2:
		$PokemonsMenu/Pokemon2.visible = true
		$PokemonsMenu/Pokemon3.visible = false
		infoPokemon1()
		infoPokemon2()
	elif numberPokemon == 3:
		$PokemonsMenu/Pokemon2.visible = true
		$PokemonsMenu/Pokemon3.visible = true
		infoPokemon1()
		infoPokemon2()
		infoPokemon3()

func infoPokemon1():
	$PokemonsMenu/Pokemon1/Level.text = "Cấp: " + str(Global.pokemon1.getLevel())
	$PokemonsMenu/Pokemon1/Heart.text = "Máu:              " + str(Global.pokemon1CurrentHeart) + "/" + str(Global.pokemon1.getHeart())
	$PokemonsMenu/Pokemon1/Energy.text = "Năng lượng: " + str(Global.pokemon1.getEnergy())
	$PokemonsMenu/Pokemon1/AttackDamage.text = "Sát thương gốc:              " + str(Global.pokemon1.getAttackDamage())
	$PokemonsMenu/Pokemon1/Defense.text = "Phòng thủ gốc:                " + str(Global.pokemon1.getDefense())
	$PokemonsMenu/Pokemon1/LevelUp.text = "Nâng cấp: " + str(Global.pokemon1.getLevel() * 100) + " xu"

func infoPokemon2():
	if Global.pokemon2ID == 0:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon0
	elif Global.pokemon2ID == 1:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon1
	elif Global.pokemon2ID == 2:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon2
	elif Global.pokemon2ID == 3:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon3
	elif Global.pokemon2ID == 4:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon4
	elif Global.pokemon2ID == 5:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon5
	elif Global.pokemon2ID == 6:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon6
	elif Global.pokemon2ID == 7:
		$PokemonsMenu/Pokemon2/Img.texture = imgPokemon7
	
	$PokemonsMenu/Pokemon2/Name.text = Global.pokemon2.getName()
	$PokemonsMenu/Pokemon2/Type.text = "Hệ: " + Global.pokemon2.getTypeName()
	$PokemonsMenu/Pokemon2/Level.text = "Cấp: " + str(Global.pokemon2.getLevel())
	$PokemonsMenu/Pokemon2/Heart.text = "Máu:              " + str(Global.pokemon2CurrentHeart) + "/" + str(Global.pokemon2.getHeart())
	$PokemonsMenu/Pokemon2/Energy.text = "Năng lượng: " + str(Global.pokemon2.getEnergy())
	$PokemonsMenu/Pokemon2/AttackDamage.text = "Sát thương gốc:              " + str(Global.pokemon2.getAttackDamage())
	$PokemonsMenu/Pokemon2/Defense.text = "Phòng thủ gốc:                " + str(Global.pokemon2.getDefense())
	$PokemonsMenu/Pokemon2/LevelUp.text = "Nâng cấp: " + str(Global.pokemon2.getLevel() * 100) + " xu"

func infoPokemon3():
	if Global.pokemon3ID == 0:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon0
	elif Global.pokemon3ID == 1:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon1
	elif Global.pokemon3ID == 2:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon2
	elif Global.pokemon3ID == 3:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon3
	elif Global.pokemon3ID == 4:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon4
	elif Global.pokemon3ID == 5:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon5
	elif Global.pokemon3ID == 6:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon6
	elif Global.pokemon3ID == 7:
		$PokemonsMenu/Pokemon3/Img.texture = imgPokemon7
	
	$PokemonsMenu/Pokemon3/Name.text = Global.pokemon3.getName()
	$PokemonsMenu/Pokemon3/Type.text = "Hệ: " + Global.pokemon3.getTypeName()
	$PokemonsMenu/Pokemon3/Level.text = "Cấp: " + str(Global.pokemon3.getLevel())
	$PokemonsMenu/Pokemon3/Heart.text = "Máu:              " + str(Global.pokemon3CurrentHeart) + "/" + str(Global.pokemon3.getHeart())
	$PokemonsMenu/Pokemon3/Energy.text = "Năng lượng: " + str(Global.pokemon3.getEnergy())
	$PokemonsMenu/Pokemon3/AttackDamage.text = "Sát thương gốc:              " + str(Global.pokemon3.getAttackDamage())
	$PokemonsMenu/Pokemon3/Defense.text = "Phòng thủ gốc:                " + str(Global.pokemon3.getDefense())
	$PokemonsMenu/Pokemon3/LevelUp.text = "Nâng cấp: " + str(Global.pokemon3.getLevel() * 100) + " xu"

func levelUpPokemon1():
	if Global.player.getMoney() >= (Global.pokemon1.getLevel() * 100):
		var oldLevel = Global.pokemon1.getLevel()
		Global.loadPokemon1(oldLevel + 1, Global.pokemon1CurrentHeart)
		Global.player.deduction(Global.pokemon1.getLevel() * 100)

func levelUpPokemon2():
	if Global.player.getMoney() >= (Global.pokemon2.getLevel() * 100):
		var oldLevel = Global.pokemon2.getLevel()
		Global.loadPokemon2(oldLevel + 1, Global.pokemon2CurrentHeart)
		Global.player.deduction(Global.pokemon2.getLevel() * 100)


func levelUpPokemon3():
	if Global.player.getMoney() >= (Global.pokemon1.getLevel() * 100):
		var oldLevel = Global.pokemon1.getLevel()
		Global.loadPokemon2(oldLevel + 1, Global.pokemon2CurrentHeart)
		Global.player.deduction(Global.pokemon2.getLevel() * 100)

#Cài đặt Menu 
func _on_full_screen_toggled_toggled(toggled_on):
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
	Global.fullScreen = toggled_on

func _on_volume_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	
	if value == -10:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)
	
	Global.volume = value

func _on_quit_button_pressed():
	SaveLoad.saveGame()
	get_tree().quit()

