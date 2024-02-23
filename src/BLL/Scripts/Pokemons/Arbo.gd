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
		heart = (80 * Level) * 2/3
		energy = (50 * Level) * 2/3
		attackDamage = (65 * Level) * 2/3
		defense = (65 * Level) * 2/3


func skill1(enemy: Pokemon) -> int:
	if energy < 40:
		return 0
	
	reduceEnergy(40)
	enemy.reduceDefense(0.05)
	return attackDamage

func skill1Type() -> int:
	return 5

func skill1Name() -> String:
	return "Độc rắn"

func skill1Info() -> String:
	return "Phun nọc độc chứa axit về đối phương.
			Sát thương: " + str(attackDamage) + "
			Năng lượng: 40
			Giảm 5% giáp kẻ thù"

func skill2():
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	addBuffDamage(0.03)

func skill2Name() -> String:
	return "Nanh rắn"

func skill2Info() -> String:
	return "Arbo tiết độc bao quanh nanh bản thân.
			Năng lượng: 50
			Tăng 3% sát thương"
