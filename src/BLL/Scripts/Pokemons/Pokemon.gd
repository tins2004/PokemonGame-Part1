extends Node
class_name Pokemon

var namePoke: String = ""
var level: int = 1
var type: int = 0 #0: điện, 1: cỏ, 2:lửa, 3: nước, 4: đất, 5: độc
var typeName: String = ""
var heart: int = 100
var energy: int = 100
var attackDamage: int = 100
var defense: int = 50

#Getter / Setter
func getName() -> String:
	return namePoke
func setName(value: String):
	namePoke = value

func getLevel() -> int:
	return level
func setLevel(value: int):
	if value < 1:
		value = 1
	level = value

func getType() -> int:
	return type
func setType(value: int):
	type = value

func getTypeName() -> String:
	return typeName
func setTypeName(value: String):
	return typeName

func getHeart() -> int:
	return heart
func setHeart(value: int):
	heart = value

func getEnergy() -> int:
	return energy
func setEnergy(value: int):
	energy = value

func getAttackDamage() -> int:
	return attackDamage
func setAttackDamage(value: int):
	attackDamage = value

func getDefense() -> int:
	return defense
func setDefense(value: int):
	defense = value

#Add Effect Pokemon
func addDamage(Damage: int, ElementSkill: int):
	var elementSkillDamage = 1
	if type == 0:# điện
		if ElementSkill == 0:
			elementSkillDamage = 1/2
		elif ElementSkill == 4:
			elementSkillDamage = 2
	elif type == 1:# cỏ
		if ElementSkill == 0:
			elementSkillDamage = 1/2
		elif ElementSkill == 1:
			elementSkillDamage = 1/2
		elif ElementSkill == 2:
			elementSkillDamage = 2
		elif ElementSkill == 3:
			elementSkillDamage = 1/2
		elif ElementSkill == 4:
			elementSkillDamage = 1/2
		elif ElementSkill == 5:
			elementSkillDamage = 2
	elif type == 2:# lửa
		if ElementSkill == 1:
			elementSkillDamage = 1/2
		elif ElementSkill == 2:
			elementSkillDamage = 1/2
		elif ElementSkill == 3:
			elementSkillDamage = 2
		elif ElementSkill == 4:
			elementSkillDamage = 2
	elif type == 3:# nước
		if ElementSkill == 0:
			elementSkillDamage = 2
		elif ElementSkill == 1:
			elementSkillDamage = 2
		elif ElementSkill == 2:
			elementSkillDamage = 1/2
		elif ElementSkill == 3:
			elementSkillDamage = 1/2
	elif type == 4:# đất
		if ElementSkill == 0:
			elementSkillDamage = 0
		elif ElementSkill == 1:
			elementSkillDamage = 2
		elif ElementSkill == 3:
			elementSkillDamage = 2
		elif ElementSkill == 5:
			elementSkillDamage = 1/2
	elif type == 5:# độc
		if ElementSkill == 1:
			elementSkillDamage = 1/2
		elif ElementSkill == 4:
			elementSkillDamage = 2
		elif ElementSkill == 5:
			elementSkillDamage = 1/2
	
	var totalDagame = (Damage*elementSkillDamage) - (defense/2)
	if totalDagame > 0:
		heart -= totalDagame
	else:
		heart -= 10

func addBuffHeart(Heart: int):
	heart += Heart

func addBuffEnergy(Energy: int):
	energy += Energy

func addBuffHeartFloat(Heart: float):
	heart += heart*Heart

func addBuffDamage(Damage: float):
	attackDamage += attackDamage*Damage

func addBuffDefense(Defense: float):
	defense += defense*Defense

func reduceHeartFloat(Heart: float):
	heart -= heart*Heart

func reduceDamage(Damage: float):
	attackDamage -= attackDamage*Damage

func reduceDefense(Defense: float):
	defense -= defense*Defense

func reduceEnergy(Energy: int):
	energy -= Energy

func reduceEnergyFloat(Energy: float):
	energy -= energy*Energy 

#Attack
func normalAttack() -> int:
	return attackDamage

func normalNameAttack() -> String:
	return "Tấn công cơ bản"

func normalInfoAttack() -> String:
	return "Gây sát thương vật lý lên 
			đối phương.
			Sát thương: " + str(attackDamage) +"
			Không tiêu hao năng lượng."
