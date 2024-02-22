extends CharacterBody2D

const SPEED_WALK = 200

@onready var spriteFemale = preload("res://img/Player/female.png")
@onready var spriteMale = preload("res://img/Player/male.png")

@onready var animPlayer = $AnimationPlayer
@onready var spritePlayer = $Sprite2D

func _ready():
	if Global.player.getSex():
		spritePlayer.texture = spriteMale
	else:
		spritePlayer.texture = spriteFemale
	
	print(Global.player.getName())

func _process(delta):
	if $AudioIdle.get_playback_position() == 0 or Global.wonPokemon:
		$AudioIdle.play()
		Global.wonPokemon = false


func _physics_process(delta):
	velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED_WALK
	
	if velocity.x != 0 or velocity.y != 0:
		Global.isWalking = true
	else:
		Global.isWalking = false
	
	velocity = checkWalkPlayer(velocity)
	animWalkPlayer(velocity)
	move_and_slide()

func checkWalkPlayer(velocity: Vector2) -> Vector2:
	if velocity.x != 0 and velocity.y != 0:
		velocity.y = 0
		return velocity
	return velocity

func animWalkPlayer(velocity: Vector2):
	if velocity.x == 0 and velocity.y == 0:
		animPlayer.play("Idle")
	
	if velocity.x > 0:
		animPlayer.play("WalkRight")
	elif velocity.x < 0:
		animPlayer.play("WalkLeft")
	else:
		if velocity.y < 0:
			animPlayer.play("WalkUp")
		elif velocity.y > 0:
			animPlayer.play("WalkDown")
