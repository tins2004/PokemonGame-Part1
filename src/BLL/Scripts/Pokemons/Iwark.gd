class_name Iwark extends Pokemon

func _init(Level: int):
	namePoke = "Iwark"
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
	enemy.reduceDefense(0.03)
	return (attackDamage + 40)

func skill1Type() -> int:
	return 4

func skill1Name() -> String:
	return "Đuôi sắt"

func skill1Info() -> String:
	return "Vung đuôi bọc thép vào đối phương.
			Sát thương: " + str(attackDamage + 40) + "
			Năng lượng: 70
			Giảm 3% giáp kẻ thù"

func skill2():
	if energy < 50:
		return 0
	
	reduceEnergy(50)
	addBuffDefense(0.1)

func skill2Name() -> String:
	return "Mình đồng da sắt"

func skill2Info() -> String:
	return "Iwark bọc cơ thể một lớp giáp sắt.
			Năng lượng: 50
			Tăng 10% giáp"
