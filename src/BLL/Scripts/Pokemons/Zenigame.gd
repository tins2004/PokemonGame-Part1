class_name Zenigame extends Pokemon

func _init(Level: int):
	namePoke = "Zenigame"
	level = Level
	type = 3
	typeName = "Nước"
	if level == 1:
		heart = 90
		energy = 50
		attackDamage = 60
		defense = 70
	elif level == 2:
		const LEVELUP2 = 20
		heart = 90 + LEVELUP2
		energy = 50 + LEVELUP2
		attackDamage = 60 + LEVELUP2
		defense = 70 + LEVELUP2
	else:
		heart = (90 * Level) * 2/3
		energy = (50 * Level) * 2/3
		attackDamage = (50 * Level) * 2/3
		defense = (70 * Level) * 2/3


func skill1(enemy: Pokemon) -> int:
	if energy < 30:
		return 0
	
	reduceEnergy(30)
	enemy.reduceEnergyFloat(0.12)
	return (attackDamage)

func skill1Type() -> int:
	return 3

func skill1Name() -> String:
	return "Súng nước"

func skill1Info() -> String:
	return "Bắng tia nước áp lực 
			lớn vào kẻ thù.
			Sát thương: " + str(attackDamage) + "
			Năng lượng: 30
			Giảm 12% năng lượng kẻ thù"

func skill2():
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	addBuffDefense(0.07)

func skill2Name() -> String:
	return "Bóng nước"

func skill2Info() -> String:
	return "Zenigame tạo ra bong bóng 
			nước bao quanh cơ thể.
			Năng lượng: 50
			Tăng 7% giáp"
