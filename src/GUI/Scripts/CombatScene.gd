extends CanvasLayer

@onready var animPoke = $AnimationPlayer
@onready var timer = $Timer
@onready var timerAttackTaget = $TimerAttackTaget

var canSelect = false
var numberSelect = 0
var canAttack = true
var countRoundCombat = 1

var pokemonPlayer
var pokemonEnemy
var randomModule = RandomNumberGenerator.new()
var levelRandom = RandomNumberGenerator.new()
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
	initPlayerPokemon()
	
	$Panel/InfoCombat/OptionInfo.visible = false
	$AudioCombat.play()
	
	timerAttackTaget.paused = true

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
	
	if pokemonPlayer.getHeart() <= 0:
		pokemonPlayer.setHeart(0)
		lose() 

func keyInput():
	if Input.is_physical_key_pressed(KEY_Z):
		selectAttack(0)
	if Input.is_physical_key_pressed(KEY_X):
		selectAttack(1)
	if Input.is_physical_key_pressed(KEY_C):
		selectAttack(2)
	if Input.is_physical_key_pressed(KEY_A):
		pass
	if Input.is_physical_key_pressed(KEY_S):
		pass
	
	if canSelect:
		if Input.is_physical_key_pressed(KEY_ENTER):
			if numberSelect == 0 or numberSelect == 1 or numberSelect == 2:
				playerAttack()
				canAttack = false
			elif numberSelect == 3:
				pass
			elif numberSelect == 4:
				pass
			elif numberSelect == 5:
				giveUp()
			$Panel/InfoCombat/OptionInfo.visible = false
			canSelect = false
		if Input.is_physical_key_pressed(KEY_ESCAPE):
			$Panel/InfoCombat/OptionInfo.visible = false
			canSelect = false

func AIPokemon():
	var PokemonSkill = levelRandom.randi_range(0, 2)
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
	
	canAttack = true

func _on_timer_attack_taget_timeout():
	AIPokemon()
	countRoundCombat += 1
	print(countRoundCombat)
	timerAttackTaget.paused = true

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
	await get_tree().create_timer(1).timeout
	giveUp()

func lose():
	animPoke.play("Lose")
	$WonPanel/Label.text = "Lose"
	$AudioCombat.stop()
	await get_tree().create_timer(1).timeout
	giveUp()

func giveUp():
	get_tree().paused = false
	Global.endCombat = true
	queue_free()

#Button
func _on_skill_1_pressed():
	selectAttack(0)

func _on_skill_2_pressed():
	selectAttack(1)

func _on_skill_3_pressed():
	selectAttack(2)

func _on_change_pokemon_pressed():
	pass # Replace with function body.


func _on_thu_phuc_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	selectQuit()

func _on_yes_pressed():
	if numberSelect == 0 or numberSelect == 1 or numberSelect == 2:
		playerAttack()
		canAttack = false
	elif numberSelect == 3:
		pass
	elif numberSelect == 4:
		pass
	elif numberSelect == 5:
		giveUp()
	$Panel/InfoCombat/OptionInfo.visible = false
	canSelect = false

func _on_no_pressed():
	$Panel/InfoCombat/OptionInfo.visible = false
	canSelect = false

#Pokemon Show
func initEnemyPokemon():
	var pokemonID = levelRandom.randi_range(8, 15)
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
	
	realHeartEnemy = pokemonEnemy.getHeart()
	realEnergyEnemy = pokemonEnemy.getEnergy()
	realAttackDamageEnemy = pokemonEnemy.getAttackDamage()
	realDefenseEnemy = pokemonEnemy.getDefense()

func initPlayerPokemon():
	pokemonPlayer = Picachu.new(Global.pokemonLevel)
	$PlayerPokemon.texture = imgPokemon0
	
	realHeartPlayer = pokemonPlayer.getHeart()
	realEnergyPlayer = pokemonPlayer.getEnergy()
	realAttackDamagePlayer = pokemonPlayer.getAttackDamage()
	realDefensePlayer = pokemonPlayer.getDefense()
	
	$Panel/OptionBox/Skill2.text = "[ X ] | " + pokemonPlayer.skill1Name()
	$Panel/OptionBox/Skill3.text = "[ C ] | " + pokemonPlayer.skill2Name()

func enemyPokemonInfo():
	$InfoEnemy/Name.text = pokemonEnemy.getName()
	$InfoEnemy/HP.text = "HP: " + str(pokemonEnemy.getHeart()) + "/" + str(realHeartEnemy)
	$InfoEnemy/MP.text = "MP: " + str(pokemonEnemy.getEnergy()) + "/" + str(realEnergyEnemy)
	$Panel/InfoCombat/Enemy/EnemyName.text = "Tên: " + pokemonEnemy.getName() + " - Cấp độ: " + str(pokemonEnemyLevel) + " - Hệ: " + str(pokemonEnemy.getTypeName())
	$Panel/InfoCombat/Enemy/EnemyInfo.text = "Sát thương:  " + str(pokemonEnemy.getAttackDamage()) +"   
												Giáp:              " + str(pokemonEnemy.getDefense())

func playerPokemonInfo():
	$InfoPlayer/Name.text = pokemonPlayer.getName()
	$InfoPlayer/HP.text = "HP: " + str(pokemonPlayer.getHeart()) + "/" + str(realHeartPlayer)
	$InfoPlayer/MP.text = "MP: " + str(pokemonPlayer.getEnergy()) + "/" + str(realEnergyPlayer)
	$Panel/InfoCombat/Player/PlayerName.text = "Tên: " + pokemonPlayer.getName() + " - Cấp độ: " + str(Global.pokemonLevel) + " - Hệ: " + str(pokemonPlayer.getTypeName())
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
	
