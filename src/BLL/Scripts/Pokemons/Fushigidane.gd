class_name Fushigidane extends Pokemon

func _init(Level: int):
	namePoke = "Fushigidane"
	level = Level
	type = 1
	typeName = "Cỏ, Độc"
	if level == 1:
		heart = 80
		energy = 50
		attackDamage = 60
		defense = 70
	elif level == 2:
		const LEVELUP2 = 20
		heart = 80 + LEVELUP2
		energy = 50 + LEVELUP2
		attackDamage = 60 + LEVELUP2
		defense = 70 + LEVELUP2
	else:
		heart = (80 * Level) * 2/3
		energy = (50 * Level) * 2/3
		attackDamage = (60 * Level) * 2/3
		defense = (70 * Level) * 2/3



func skill1(enemy: Pokemon) -> int:
	if energy < 40:
		return 0
	
	reduceEnergy(40)
	enemy.reduceDefense(0.05)
	return (attackDamage)

func skill1Type() -> int:
	return 1

func skill1Name() -> String:
	return "Roi mây"

func skill1Info() -> String:
	return "Đánh roi liên tục vào đối phương.
			Sát thương: " + str(attackDamage) + "
			Năng lượng: 40
			Giảm 5% giáp kẻ thù"

func skill2():
	if energy < 50:
		return 0
	
	addBuffHeart(50)
	addBuffEnergy(50)

func skill2Name() -> String:
	return "Bóng nước"

func skill2Info() -> String:
	return "Fushigidane tự hồi phục
			bằng năng lượng thiên nhiên.
			Không tiêu hao năng lượng
			Hồi 50 máu, 50 năng lượng"
