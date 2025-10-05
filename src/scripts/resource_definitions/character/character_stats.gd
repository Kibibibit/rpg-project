extends Resource
class_name CharacterStats

@export
var max_hp: int = 0
@export
var max_mp: int = 0
@export
var strength: int = 0
@export
var magic: int = 0
@export
var agility: int = 0
@export
var defense: int = 0
@export
var luck: int = 0

func get_stat(p_stat: Stat.Type) -> int:
	match p_stat:
		Stat.MAX_HP:
			return max_hp
		Stat.MAX_MP:
			return max_mp
		Stat.STRENGTH:
			return strength
		Stat.MAGIC:
			return magic
		Stat.AGILITY:
			return agility
		Stat.DEFENSE:
			return defense
		Stat.LUCK:
			return luck
		_:
			push_error("Invalid stat type: %s" % str(p_stat))
			return 0
