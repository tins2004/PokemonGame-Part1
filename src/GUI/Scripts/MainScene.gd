extends CanvasLayer

@onready var curSceneGame = "res://src/GUI/Scenes/Maps/GameScene.tscn"

@onready var animScene = $AnimationScene
@onready var animSex = $InitMenu/AnimationSex

@onready var startMenu = $StartMenu
@onready var initMenu = $InitMenu
@onready var continueButton = $StartMenu/ContinueGameButton

func _ready():
	animScene.play("SetScale")
	
	initMenu.visible = false
	startMenu.visible = true
	animScene.play("OpenStartMenu")
	
	continueButton.visible = !Global.isFirstStartGame

#Animation Scene
func joinScene_StartToInit():
	initMenu.visible = true
	animScene.play("OpenInitMenu")
	startMenu.visible = false
	

func backScene_InitToStart():
	startMenu.visible = true
	animScene.play("OpenStartMenu")
	initMenu.visible = false

#Button even start menu
func _on_new_game_button_pressed():
	joinScene_StartToInit()

func _on_continue_game_button_pressed():
	get_tree().change_scene_to_file(curSceneGame)


#Button even init menu
func _on_init_back_button_pressed():
	backScene_InitToStart()

func _on_female_button_pressed():
	Global.player.setSex(false)
	animSex.play("Female")

func _on_male_button_pressed():
	Global.player.setSex(true)
	animSex.play("Male")

func _on_name_edit_text_changed(new_text):
	Global.player.setName(new_text)

func _on_next_button_pressed():
	SaveLoad.saveGame()
	get_tree().change_scene_to_file(curSceneGame)

