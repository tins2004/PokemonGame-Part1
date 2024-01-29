extends Node

var save_path = "user://data.save"

func saveData():
	var save_data = {
		"namePlayer" : Global.player.getName(),
		"sexPlayer" :Global.player.getSex()
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
		
		Global.player.setName(node_data["namePlayer"])
		Global.player.setSex(node_data["sexPlayer"])
