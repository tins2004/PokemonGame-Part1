class_name Isitsubute extends Pokemon

func _init(Level: int):
	namePoke = "Isitsubute"
	level = Level
	type = 4
	typeName = "Đá"
	if level == 1:
		heart = 80
		energy = 50
		attackDamage = 70
		defense = 70
	elif level == 2:
		const LEVELUP2 = 20
		heart = 80 + LEVELUP2
		energy = 50 + LEVELUP2
		attackDamage = 70 + LEVELUP2
		defense = 70 + LEVELUP2
	else:
		heart = (80 * Level) * 2/3
		energy = (50 * Level) * 2/3
		attackDamage = (70 * Level) * 2/3
		defense = (70 * Level) * 2/3



func skill1(enemy: Pokemon) -> int:
	if energy < 70:
		return 0
	
	reduceEnergy(70)
	enemy.reduceHeartFloat(0.1)
	return (attackDamage + 30)

func skill1Type() -> int:
	return 4

func skill1Name() -> String:
	return "Tay đá"

func skill1Info() -> String:
	return "Tung ra nắm đấm đã được cường hóa.
			Sát thương: " + str(attackDamage + 30) + "
			Năng lượng: 70
			Giảm 10% máu kẻ thù"

func skill2():
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	addBuffDamage(0.03)

func skill2Name() -> String:
	return "Mài đá"

func skill2Info() -> String:
	return "Isitsubute tự biến cơ thể 
			thành vũ khí sắt bén.
			Năng lượng: 50
			Tăng 3% sát thương"

