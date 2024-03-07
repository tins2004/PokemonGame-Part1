extends CanvasLayer

@onready var curSceneGame = "res://src/GUI/Scenes/Maps/GameScene.tscn"

@onready var animScene = $AnimationScene
@onready var animSex = $InitMenu/AnimationSex

@onready var firstScene = $FirstScene
@onready var startMenu = $StartMenu
@onready var initMenu = $InitMenu
@onready var optionMenu = $OptionMenu
@onready var continueButton = $StartMenu/ContinueGameButton

@onready var master_bus = AudioServer.get_bus_index("Master")

func _ready():
	animScene.play("SetScale")
	
	continueButton.visible = !Global.isFirstStartGame

func _on_start_game_pressed():
	joinScene_StartMenu()
	firstScene.visible = false

#Animation Scene
func joinScene_InitMenu():
	initMenu.visible = true
	animScene.play("OpenInitMenu")
	startMenu.visible = false
	optionMenu.visible = false

func joinScene_OptionMenu():
	optionMenu.visible = true
	animScene.play("OpenOptionMenu")
	startMenu.visible = false
	initMenu.visible = false

func joinScene_StartMenu():
	startMenu.visible = true
	animScene.play("OpenStartMenu")
	initMenu.visible = false
	optionMenu.visible = false

func _on_back_button_pressed():
	joinScene_StartMenu()

#Button even start menu
func _on_new_game_button_pressed():
	joinScene_InitMenu()

func _on_continue_game_button_pressed():
	get_tree().change_scene_to_file(curSceneGame)

func _on_option_button_pressed():
	$OptionMenu/VolumeSlider.set_value_no_signal(Global.volume)
	$OptionMenu/FullScreenToggled.button_pressed = Global.fullScreen
	
	joinScene_OptionMenu()

func _on_quit_button_pressed():
	if not Global.isFirstStartGame:
		SaveLoad.loadGame()
	get_tree().quit()



#Button even init menu
func _on_female_button_pressed():
	Global.player.setSex(false)
	animSex.play("Female")

func _on_male_button_pressed():
	Global.player.setSex(true)
	animSex.play("Male")

func _on_name_edit_text_changed(new_text):
	Global.player.setName(new_text)

func _on_next_button_pressed():
	Global.isFirstStartGame = true
	
	SaveLoad.saveGame()
	SaveLoad.loadGame()
	get_tree().change_scene_to_file(curSceneGame)

#Button even option menu
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

