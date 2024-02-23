extends Area2D

@onready var timer = $Timer

@onready var comnbatScene = preload("res://src/GUI/Scenes/Menus/CombatScene.tscn")

var canFindPokemon = false
var timeCanMeetPokemon = RandomNumberGenerator.new()


func _process(delta):
	if canFindPokemon and Global.isWalking:
		findPokemon()

func findPokemon():
	if timer.time_left == 0:
		var newscene = comnbatScene.instantiate()
		get_tree().root.add_child(newscene)
		get_tree().paused = true
		
		timer.start(timeCanMeetPokemon.randi_range(7, 15))

func _on_body_entered(body):
	if(body.name == "Player"):
		timer.start(timeCanMeetPokemon.randi_range(3, 10))
		canFindPokemon = true 

func _on_body_exited(body):
	if(body.name == "Player"):
		canFindPokemon = false
