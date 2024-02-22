class_name Picachu extends Pokemon

func _init(Level: int):
	namePoke = "Picachu"
	level = Level
	type = 0
	typeName = "Điện"
	if level == 1:
		heart = 60
		energy = 50
		attackDamage = 75
		defense = 70
	elif level == 2:
		const LEVELUP2 = 20
		heart = 60 + LEVELUP2
		energy = 50 + LEVELUP2
		attackDamage = 75 + LEVELUP2
		defense = 70 + LEVELUP2
	else:
		heart = (60 * Level) / 2
		energy = (50 * Level) / 2
		attackDamage = (75 * Level) / 2
		defense = (70 * Level) / 2


func skill1() -> int:
	return 10

func skill1Type() -> int:
	return 0

func skill1Name() -> String:
	return "Skill 1"

func skill1Info() -> String:
	return "?????
			Gây: 10 sát thương
			Tiêu hao: 50 năng lượng."

func skill2():
	addBuffHeart(10)

func skill2Name() -> String:
	return "Skill 2"

func skill2Info() -> String:
	return "?????
			Hồi: 10 máu
			Tiêu hao: 50 năng lượng."
