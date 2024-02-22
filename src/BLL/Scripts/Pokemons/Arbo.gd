class_name Arbo extends Pokemon

func _init(Level: int):
	namePoke = "Arbo"
	level = Level
	type = 5
	typeName = "Độc, nước"
	if level == 1:
		heart = 80
		energy = 50
		attackDamage = 65
		defense = 65
	elif level == 2:
		const LEVELUP2 = 20
		heart = 80 + LEVELUP2
		energy = 50 + LEVELUP2
		attackDamage = 65 + LEVELUP2
		defense = 65 + LEVELUP2
	else:
		heart = (80 * Level) / 2
		energy = (50 * Level) / 2
		attackDamage = (65 * Level) / 2
		defense = (65 * Level) / 2


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
