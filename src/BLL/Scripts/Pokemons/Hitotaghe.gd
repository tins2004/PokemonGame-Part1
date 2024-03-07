class_name Hitotaghe extends Pokemon

func _init(Level: int):
	namePoke = "Hitotaghe"
	level = Level
	type = 2
	typeName = "Lửa"
	if level == 1:
		heart = 80
		energy = 50
		attackDamage = 70
		defense = 60
	elif level == 2:
		const LEVELUP2 = 20
		heart = 80 + LEVELUP2
		energy = 50 + LEVELUP2
		attackDamage = 70 + LEVELUP2
		defense = 60 + LEVELUP2
	else:
		heart = (80 * Level) * 2/3
		energy = (50 * Level) * 2/3
		attackDamage = (70 * Level) * 2/3
		defense = (60 * Level) * 2/3


func skill1(enemy: Pokemon) -> int:
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	enemy.reduceHeartFloat(0.07)
	return (attackDamage + 20)

func skill1Type() -> int:
	return 2

func skill1Name() -> String:
	return "Phun lửa"

func skill1Info() -> String:
	return "Phun lửa và đốt cháy kẻ thù. 
			Sát thương: " + str(attackDamage + 20) + "
			Năng lượng: 50
			Giảm 7% máu kẻ thù"

func skill2():
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	addBuffDamage(0.03)

func skill2Name() -> String:
	return "Nhiệt huyết"

func skill2Info() -> String:
	return "Đốt nóng ngọn lửa trong Hirotaghe.
			Năng lượng: 50
			Tăng 3% sát thương"
