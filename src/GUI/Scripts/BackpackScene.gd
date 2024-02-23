extends CanvasLayer

var optionMenu = 0 #0: Hành trang, 1: Pokemons, 2: Bản đồ, 3: Hướng dẫn, 4: Cài dặt, 5: Nạp tiền

@onready var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	$CaiDatMenu/VolumeSlider.set_value_no_signal(Global.volume)
	$CaiDatMenu/FullScreenToggled.button_pressed = Global.fullScreen


func _process(delta):
	if Input.is_physical_key_pressed(KEY_Q):
		queue_free()
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
	queue_free()

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
	elif numberPokemon == 3:
		$PokemonsMenu/Pokemon2.visible = true
		$PokemonsMenu/Pokemon3.visible = true

func infoPokemon1():
	$PokemonsMenu/Pokemon1/Level.text = "Cấp: " + str(Global.pokemon1.getLevel())
	$PokemonsMenu/Pokemon1/Heart.text = "Máu:              " + str(Global.pokemon1.getHeart()) + "/" + str(Global.pokemon1.getHeart())
	$PokemonsMenu/Pokemon1/Energy.text = "Năng lượng: " + str(Global.pokemon1.getEnergy()) + "/" + str(Global.pokemon1.getEnergy())
	$PokemonsMenu/Pokemon1/AttackDamage.text = "Sát thương gốc:              " + str(Global.pokemon1.getAttackDamage())
	$PokemonsMenu/Pokemon1/Defense.text = "Phòng thủ gốc:                " + str(Global.pokemon1.getDefense())

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
