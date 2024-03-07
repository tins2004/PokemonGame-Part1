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
		heart = (60 * Level) * 2/3
		energy = (50 * Level) * 2/3 
		attackDamage = (75 * Level) * 2/3
		defense = (70 * Level) * 2/3


func skill1(enemy: Pokemon) -> int:
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	enemy.reduceDefense(0.03)
	return (attackDamage + 20)

func skill1Type() -> int:
	return 0

func skill1Name() -> String:
	return "Điện 100.000 Vôn"

func skill1Info() -> String:
	return "Phóng luồn điện sát thương và 
			làm tê liệt giáp kẻ thù.
			Sát thương: " + str(attackDamage + 20) + "
			Năng lượng: 50
			Giảm 3% giáp kẻ thù"

func skill2():
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	addBuffHeart(80)

func skill2Name() -> String:
	return "Kích điện"

func skill2Info() -> String:
	return "Pikachu tự kích điện bản thân.
			Năng lượng: 50
			Hồi 80 máu"
