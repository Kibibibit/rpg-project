@abstract
extends RefCounted
class_name Initiative


static func calculate(character: Character) -> int:
	return character.get_stat(Stats.Type.AGILITY)
