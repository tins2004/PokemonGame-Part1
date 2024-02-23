extends Node

var save_path = "user://data.save"

func saveData():
	var save_data
	if Global.isFirstStartGame:
		save_data = {
			"audio": Global.volume,
			"fullscreen": Global.fullScreen,
			"namePlayer" : Global.player.getName(),
			"sexPlayer" : Global.player.getSex(),
			"numberPokemon": Global.player.getNumberPokemon(),
			"pokeBall": Global.player.getPokeBall(),
			"money": Global.player.getMoney(),
			"pikachuLevel": 5,
			"pikachuCurrentHeart": (60 * 5) * 2/3,
		}
		
		return save_data
	if Global.player.getNumberPokemon() >= 2:
			save_data = {
				"audio": Global.volume,
				"fullscreen": Global.fullScreen,
				"namePlayer" : Global.player.getName(),
				"sexPlayer" : Global.player.getSex(),
				"numberPokemon": Global.player.getNumberPokemon(),
				"pokeBall": Global.player.getPokeBall(),
				"money": Global.player.getMoney(),
				"pikachuLevel": Global.pokemon1.getLevel(),
				"pikachuCurrentHeart": Global.pokemon1CurrentHeart,
				"pokemon2ID": Global.pokemon2ID,
				"pokemon2Level": Global.pokemon2.getLevel(),
				"pokemon2CurrentHeart": Global.pokemon2CurrentHeart,
			}
			if Global.player.getNumberPokemon() >= 3:
				save_data = {
					"audio": Global.volume,
					"fullscreen": Global.fullScreen,
					"namePlayer" : Global.player.getName(),
					"sexPlayer" : Global.player.getSex(),
					"numberPokemon": Global.player.getNumberPokemon(),
					"pokeBall": Global.player.getPokeBall(),
					"money": Global.player.getMoney(),
					"pikachuLevel": Global.pokemon1.getLevel(),
					"pikachuCurrentHeart": Global.pokemon1CurrentHeart,
					"pokemon2ID": Global.pokemon2ID,
					"pokemon2Level": Global.pokemon2.getLevel(),
					"pokemon2CurrentHeart": Global.pokemon2CurrentHeart,
					"pokemon3ID": Global.pokemon3ID,
					"pokemon3Level": Global.pokemon3.getLevel(),
					"pokemon3CurrentHeart": Global.pokemon3CurrentHeart,
				}
	else:
		save_data = {
			"audio": Global.volume,
			"fullscreen": Global.fullScreen,
			"namePlayer" : Global.player.getName(),
			"sexPlayer" : Global.player.getSex(),
			"numberPokemon": Global.player.getNumberPokemon(),
			"pokeBall": Global.player.getPokeBall(),
			"money": Global.player.getMoney(),
			"pikachuLevel": Global.pokemon1.getLevel(),
			"pikachuCurrentHeart": Global.pokemon1CurrentHeart,
		}
	
	return save_data

func saveGame():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	var json_string = JSON.stringify(saveData())
	file.store_line(json_string)


func loadGame():
	if not FileAccess.file_exists(save_path):
		Global.isFirstStartGame = true
		return
		
	var save_game = FileAccess.open(save_path, FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		Global.volume = node_data["audio"]
		Global.fullScreen = node_data["fullscreen"]
		Global.player.setName(node_data["namePlayer"])
		Global.player.setSex(node_data["sexPlayer"])
		Global.player.setNumberPokemon(node_data["numberPokemon"])
		Global.player.setPokeBall(node_data["pokeBall"])
		Global.player.setMoney(node_data["money"])
		
		Global.initPokemon()
		
		Global.pokemon1.setLevel(node_data["pikachuLevel"])
		Global.pokemon1CurrentHeart = node_data["pikachuCurrentHeart"]
		
		if Global.player.getNumberPokemon() >= 2:
			Global.pokemon2ID = node_data["pokemon2ID"]
			Global.pokemon2.setLevel(node_data["pokemon2Level"])
			Global.pokemon2CurrentHeart = node_data["pokemon2CurrentHeart"]
			if Global.player.getNumberPokemon() >= 3:
				Global.pokemon2ID = node_data["pokemon3ID"]
				Global.pokemon2.setLevel(node_data["pokemon3Level"])
				Global.pokemon2CurrentHeart = node_data["pokemon3CurrentHeart"]

func deleteFile():
	DirAccess.remove_absolute(save_path)
