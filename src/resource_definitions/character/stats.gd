extends Resource
class_name Stats

enum Type {
	MAX_HP,
	MAX_MP,
	STRENGTH,
	MAGIC,
	DEFENSE,
	AGILITY,
	LUCK
}

const MAX_HP := Type.MAX_HP
const MAX_MP := Type.MAX_MP
const STRENGTH := Type.STRENGTH
const MAGIC := Type.MAGIC
const DEFENSE := Type.DEFENSE
const AGILITY := Type.AGILITY
const LUCK := Type.LUCK

@export_category("Resource Stats")
@export
var max_hp: int = 0
@export
var max_mp: int = 0
@export_category("Combat Stats")
@export
var strength: int = 0
@export
var magic: int = 0
@export
var defense: int = 0
@export
var agility: int = 0
@export
var luck: int = 0

func get_stat(stat: Type) -> int:
	match stat:
		MAX_HP:
			return max_hp
		MAX_MP:
			return max_mp
		STRENGTH:
			return strength
		MAGIC:
			return magic
		DEFENSE:
			return defense
		AGILITY:
			return agility
		LUCK:
			return luck
		_:
			push_error("Invalid stat type: %s" % str(stat))
			return 0
