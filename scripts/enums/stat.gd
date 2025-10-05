## ENUM FILE
@abstract
extends EnumBase
class_name Stat


enum Type {
	STRENGTH,
	MAGIC,
	AGILITY,
	DEFENSE,
	LUCK,
	MAX_HP,
	MAX_MP
}

const STRENGTH := Type.STRENGTH
const MAGIC := Type.MAGIC
const AGILITY := Type.AGILITY
const DEFENSE := Type.DEFENSE
const LUCK := Type.LUCK
const MAX_HP := Type.MAX_HP
const MAX_MP := Type.MAX_MP

const VALUES: Array[Type] = [
	STRENGTH,
	MAGIC,
	AGILITY,
	DEFENSE,
	LUCK,
	MAX_HP,
	MAX_MP
]
