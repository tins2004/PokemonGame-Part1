extends CanvasLayer

@onready var animPoke = $AnimationPlayer
@onready var timer = $Timer
@onready var timerAttackTaget = $TimerAttackTaget
@onready var timerAttackTagetForPlayer = $TimerAttackTagetForPlayer

var canSelect = false
var numberSelect = 0
var canAttack = true
var countRoundCombat = 1
var isPokemonIndex = 0

var pokemonPlayer = Global.pokemon1
var pokemonEnemy
var randomModule = RandomNumberGenerator.new()
var ennemyID = 0
var pokemonEnemyLevel = randomModule.randi_range(1, 5)

var realHeartEnemy
var realEnergyEnemy
var realAttackDamageEnemy
var realDefenseEnemy
var realHeartPlayer
var realEnergyPlayer
var realAttackDamagePlayer
var realDefensePlayer

var imgPokemon0 = preload("res://img/Pokemons/0.jpg")
var imgPokemon1 = preload("res://img/Pokemons/1.jpg")
var imgPokemon2 = preload("res://img/Pokemons/2.jpg")
var imgPokemon3 = preload("res://img/Pokemons/3.jpg")
var imgPokemon4 = preload("res://img/Pokemons/4.jpg")
var imgPokemon5 = preload("res://img/Pokemons/5.jpg")
var imgPokemon6 = preload("res://img/Pokemons/6.jpg")
var imgPokemon7 = preload("res://img/Pokemons/7.jpg")
var imgPokemon8 = preload("res://img/Pokemons/8.jpg")
var imgPokemon9 = preload("res://img/Pokemons/9.jpg")
var imgPokemon10 = preload("res://img/Pokemons/10.jpg")
var imgPokemon11 = preload("res://img/Pokemons/11.jpg")
var imgPokemon12 = preload("res://img/Pokemons/12.jpg")
var imgPokemon13 = preload("res://img/Pokemons/13.jpg")
var imgPokemon14 = preload("res://img/Pokemons/14.jpg")
var imgPokemon15 = preload("res://img/Pokemons/15.jpg")


func _ready():
	initEnemyPokemon()
	initPlayerPokemon(0) #Picachu
	pokemonPlayer.setHeart(Global.pokemon1CurrentHeart)
	
	$Panel/InfoCombat/OptionInfo.visible = false
	$AudioCombat.play()
	
	$TimerCloseCombat.paused = true
	timerAttackTaget.paused = true
	timerAttackTagetForPlayer.paused = true

func _process(delta):
	playerPokemonInfo()
	enemyPokemonInfo()
	
	if canAttack:
		$Panel/InfoCombat/Player/PlayerTaget.visible = true
		$Panel/InfoCombat/Enemy/EnemyTaget.visible = false
		keyInput()
	else:
		$Panel/InfoCombat/Player/PlayerTaget.visible = false
		$Panel/InfoCombat/Enemy/EnemyTaget.visible = true
		timerAttackTaget.paused = false
	
	if Input.is_physical_key_pressed(KEY_Q):
		selectQuit()
	
	if pokemonEnemy.getHeart() <= 0:
		pokemonEnemy.setHeart(0)
		won()
	
	if pokemonPlayer.getHeart() <= 1:
		pokemonPlayer.setHeart(1)
		lose()

func keyInput():
	if Input.is_physical_key_pressed(KEY_Z):
		_on_skill_1_pressed()
	if Input.is_physical_key_pressed(KEY_X):
		_on_skill_2_pressed()
	if Input.is_physical_key_pressed(KEY_C):
		_on_skill_3_pressed()
	if Input.is_physical_key_pressed(KEY_A):
		_on_change_pokemon_pressed()
	if Input.is_physical_key_pressed(KEY_S):
		_on_thu_phuc_pressed()
	
	if canSelect:
		if Input.is_physical_key_pressed(KEY_ENTER):
			_on_yes_pressed()
		if Input.is_physical_key_pressed(KEY_ESCAPE):
			_on_no_pressed()

#Button
func _on_skill_1_pressed():
	selectAttack(0)

func _on_skill_2_pressed():
	selectAttack(1)

func _on_skill_3_pressed():
	selectAttack(2)

func _on_change_pokemon_pressed():
	setHeartPlayerPokemon()
	changePokemon()

func _on_thu_phuc_pressed():
	thuPhucMenu()

func _on_quit_pressed():
	selectQuit()

func _on_yes_pressed():
	if numberSelect == 0 or numberSelect == 1 or numberSelect == 2:
		playerAttack()
		canAttack = false
	elif numberSelect == 3:
		change(Global.player.getNumberPokemon())
	elif numberSelect == 4:
		thuPhuc()
	elif numberSelect == 5:
		_on_timer_close_combat_timeout()
	$Panel/InfoCombat/OptionInfo.visible = false
	canSelect = false

func _on_no_pressed():
	$Panel/InfoCombat/OptionInfo.visible = false
	canSelect = false

#Pokemon Combat
func AIPokemon():
	var PokemonSkill = randomModule.randi_range(0, 2)
	if PokemonSkill == 0:
		animPoke.play("EnemyAttack")
		$AudioAttackEffect.play()
		pokemonPlayer.addDamage(pokemonEnemy.normalAttack(), pokemonEnemy.getType())
	elif PokemonSkill == 1:
		animPoke.play("EnemyAttack")
		$AudioAttackEffect.play()
		pokemonPlayer.addDamage(pokemonEnemy.skill1(pokemonPlayer), pokemonEnemy.skill1Type())
	elif PokemonSkill == 2:
		animPoke.play("EnemyBuff")
		$AudioBuffEffect.play()
		pokemonEnemy.skill2()

func _on_timer_attack_taget_timeout():
	AIPokemon()
	countRoundCombat += 1
	print(countRoundCombat)
	timerAttackTagetForPlayer.paused = false
	timerAttackTaget.paused = true

func _on_timer_attack_taget_for_player_timeout():
	canAttack = true
	timerAttackTagetForPlayer.paused = true

func selectAttack(index: int):
	canSelect = true
	numberSelect = index
	$Panel/InfoCombat/OptionInfo.visible = true
	if numberSelect == 0:
		$Panel/InfoCombat/OptionInfo/Name.text = pokemonPlayer.normalNameAttack()
		$Panel/InfoCombat/OptionInfo/Info.text = pokemonPlayer.normalInfoAttack()
	elif numberSelect == 1:
		$Panel/InfoCombat/OptionInfo/Name.text = pokemonPlayer.skill1Name()
		$Panel/InfoCombat/OptionInfo/Info.text = pokemonPlayer.skill1Info()
	elif numberSelect == 2:
		$Panel/InfoCombat/OptionInfo/Name.text = pokemonPlayer.skill2Name()
		$Panel/InfoCombat/OptionInfo/Info.text = pokemonPlayer.skill2Info()

func playerAttack():
	if numberSelect == 0:
		animPoke.play("PlayerAttack")
		$AudioAttackEffect.play()
		pokemonEnemy.addDamage(pokemonPlayer.normalAttack(), pokemonPlayer.getType())
	elif numberSelect == 1:
		animPoke.play("PlayerAttack")
		$AudioAttackEffect.play()
		pokemonEnemy.addDamage(pokemonPlayer.skill1(pokemonEnemy), pokemonPlayer.skill1Type())
	elif numberSelect == 2:
		animPoke.play("PlayerBuff")
		$AudioBuffEffect.play()
		pokemonPlayer.skill2()

func selectQuit():
	canSelect = true
	numberSelect = 5
	$Panel/InfoCombat/OptionInfo.visible = true
	$Panel/InfoCombat/OptionInfo/Name.text = "Đầu hàng"
	$Panel/InfoCombat/OptionInfo/Info.text = "Bạn có muốn đầu hàng không?"

func won():
	animPoke.play("Won")
	$WonPanel/Label.text = "Won"
	$AudioCombat.stop()
	$TimerCloseCombat.paused = false

func lose():
	animPoke.play("Won")
	$WonPanel/Label.text = "Lose"
	$AudioCombat.stop()
	$TimerCloseCombat.paused = false

func _on_timer_close_combat_timeout():
	setHeartPlayerPokemon()
	get_tree().paused = false
	Global.endCombat = true
	queue_free()


func setHeartPlayerPokemon():
	if pokemonPlayer.getHeart() >= realHeartPlayer:
		return
	
	if isPokemonIndex == 0:
		Global.pokemon1CurrentHeart = pokemonPlayer.getHeart()
		Global.pokemon1.setHeart(realHeartPlayer)
		print(Global.pokemon1CurrentHeart)
	elif isPokemonIndex == 1:
		Global.pokemon2CurrentHeart = pokemonPlayer.getHeart()
		Global.pokemon2.setHeart(realHeartPlayer)
	elif isPokemonIndex == 2:
		Global.pokemon3CurrentHeart = pokemonPlayer.getHeart()
		Global.pokemon3.setHeart(realHeartPlayer)

#Pokemon Show
func initEnemyPokemon():
	var pokemonID = randomModule.randi_range(8, 15)
	if pokemonID == 8:
		pokemonEnemy = Picachu.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon8
	elif pokemonID == 9:
		pokemonEnemy = Fushigidane.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon9
	elif pokemonID == 10:
		pokemonEnemy = Hitotaghe.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon10
	elif pokemonID == 11:
		pokemonEnemy = Zenigame.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon11
	elif pokemonID == 12:
		pokemonEnemy = Arbo.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon12
	elif pokemonID == 13:
		pokemonEnemy = Dogars.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon13
	elif pokemonID == 14:
		pokemonEnemy = Isitsubute.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon14
	elif pokemonID == 15:
		pokemonEnemy = Iwark.new(pokemonEnemyLevel)
		$EnemyPokemon.texture = imgPokemon15
	
	ennemyID = pokemonID - 8
	
	realHeartEnemy = pokemonEnemy.getHeart()
	realEnergyEnemy = pokemonEnemy.getEnergy()
	realAttackDamageEnemy = pokemonEnemy.getAttackDamage()
	realDefenseEnemy = pokemonEnemy.getDefense()

func initPlayerPokemon(pokemonID: int):
	if pokemonID == 0:
		$PlayerPokemon.texture = imgPokemon0
	elif pokemonID == 1:
		$PlayerPokemon.texture = imgPokemon1
	elif pokemonID == 2:
		$PlayerPokemon.texture = imgPokemon2
	elif pokemonID == 3:
		$PlayerPokemon.texture = imgPokemon3
	elif pokemonID == 4:
		$PlayerPokemon.texture = imgPokemon4
	elif pokemonID == 5:
		$PlayerPokemon.texture = imgPokemon5
	elif pokemonID == 6:
		$PlayerPokemon.texture = imgPokemon6
	elif pokemonID == 7:
		$PlayerPokemon.texture = imgPokemon7
	
	realHeartPlayer = pokemonPlayer.getHeart()
	realEnergyPlayer = pokemonPlayer.getEnergy()
	realAttackDamagePlayer = pokemonPlayer.getAttackDamage()
	realDefensePlayer = pokemonPlayer.getDefense()
	
	$Panel/OptionBox/Skill2.text = "[ X ] | " + pokemonPlayer.skill1Name()
	$Panel/OptionBox/Skill3.text = "[ C ] | " + pokemonPlayer.skill2Name()

func enemyPokemonInfo():
	$InfoEnemy/Name.text = pokemonEnemy.getName()
	$InfoEnemy/HP.text = "HP: " + str(pokemonEnemy.getHeart())
	$InfoEnemy/MP.text = "MP: " + str(pokemonEnemy.getEnergy())
	$Panel/InfoCombat/Enemy/EnemyName.text = "Tên: " + pokemonEnemy.getName() + " - Cấp độ: " + str(pokemonEnemyLevel) + " - Hệ: " + str(pokemonEnemy.getTypeName())
	$Panel/InfoCombat/Enemy/EnemyInfo.text = "Sát thương:  " + str(pokemonEnemy.getAttackDamage()) +"   
												Giáp:              " + str(pokemonEnemy.getDefense())

func playerPokemonInfo():
	$InfoPlayer/Name.text = pokemonPlayer.getName()
	$InfoPlayer/HP.text = "HP: " + str(pokemonPlayer.getHeart())
	$InfoPlayer/MP.text = "MP: " + str(pokemonPlayer.getEnergy())
	$Panel/InfoCombat/Player/PlayerName.text = "Tên: " + pokemonPlayer.getName() + " - Cấp độ: " + str(pokemonPlayer.getLevel()) + " - Hệ: " + str(pokemonPlayer.getTypeName())
	$Panel/InfoCombat/Player/PlayerInfo.text = "Sát thương:  " + str(pokemonPlayer.getAttackDamage()) +"   
												Giáp:              " + str(pokemonPlayer.getDefense())

func _on_timer_energy_count_timeout():
	if pokemonEnemy.getEnergy() < realEnergyEnemy:
		pokemonEnemy.addBuffEnergy(5)
		if pokemonEnemy.getEnergy() > realEnergyEnemy:
			pokemonEnemy.setEnergy(realEnergyEnemy)
	
	if pokemonPlayer.getEnergy() < realEnergyPlayer:
		pokemonPlayer.addBuffEnergy(5)
		if pokemonPlayer.getEnergy() > realEnergyPlayer:
			pokemonPlayer.setEnergy(realEnergyPlayer)
	

#Pokemon change
func changePokemon():
	canSelect = true
	numberSelect = 3
	$Panel/InfoCombat/OptionInfo.visible = true
	$Panel/InfoCombat/OptionInfo/Name.text = "Chuyển đổi Pokemon"
	$Panel/InfoCombat/OptionInfo/Info.text = "Bạn đang có " + str(Global.player.getNumberPokemon()) + " Pokemon"

func change(numberPokemon: int):
	if isPokemonIndex == 0:
		if numberPokemon == 1:
			return
		
		_on_ra_tran_2_pressed()
	elif isPokemonIndex == 1:
		if numberPokemon == 2:
			_on_ra_tran_1_pressed()
		else:
			_on_ra_tran_3_pressed()
	elif isPokemonIndex == 2:
		_on_ra_tran_1_pressed()

func _on_ra_tran_1_pressed():
	isPokemonIndex = 0
	pokemonPlayer = Global.pokemon1
	pokemonPlayer.setHeart(Global.pokemon1CurrentHeart)
	initPlayerPokemon(0) #Picachu

func _on_ra_tran_2_pressed():
	isPokemonIndex = 1
	pokemonPlayer = Global.pokemon2
	pokemonPlayer.setHeart(Global.pokemon2CurrentHeart)
	initPlayerPokemon(Global.pokemon2ID)

func _on_ra_tran_3_pressed():
	isPokemonIndex = 2
	pokemonPlayer = Global.pokemon3
	pokemonPlayer.setHeart(Global.pokemon3CurrentHeart)
	initPlayerPokemon(Global.pokemon3ID)


#Thu phục
func thuPhucMenu():
	canSelect = true
	numberSelect = 4
	$Panel/InfoCombat/OptionInfo.visible = true
	$Panel/InfoCombat/OptionInfo/Name.text = "Thu phục Pokemon"
	$Panel/InfoCombat/OptionInfo/Info.text = "Ném ra quả cầu Pokemon để
												thu phục Pokemon yếu máu.
												Quả cầu Pokemon: " + str(Global.player.getPokeBall())

func thuPhuc():
	if Global.player.getPokeBall() < 1:
		return
	
	animPoke.play("PokeBall")
	Global.player.reducePokeBall(1)
	
	$TimerPokeBall.start()
	$TimerPokeBall.paused = false

func _on_timer_poke_ball_timeout():
	var check = randomModule.randi_range(0,1)
	print(check)
	if check == 0:
		$TimerPokeBall.paused = true
		return
	
	if Global.player.getNumberPokemon() == 1:
		Global.player.setNumberPokemon(2)
		Global.pokemon2ID = ennemyID
		Global.loadPokemon2(pokemonEnemyLevel, pokemonEnemy.getHeart())
	elif Global.player.getNumberPokemon() == 2:
		Global.player.setNumberPokemon(3)
		Global.pokemon3ID = ennemyID
		Global.loadPokemon3(pokemonEnemyLevel, pokemonEnemy.getHeart())
	
	_on_timer_close_combat_timeout()



