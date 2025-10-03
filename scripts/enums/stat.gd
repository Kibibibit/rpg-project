## ENUM FILE
@abstract
extends EnumBase
class_name Stat


enum Type {
	STRENGTH,
	MAGIC,
	AGILITY,
	DEFENSE,
	LUCK
}

const STRENGTH := Type.STRENGTH
const MAGIC := Type.MAGIC
const AGILITY := Type.AGILITY
const DEFENSE := Type.DEFENSE
const LUCK := Type.LUCK

const VALUES: Array[Type] = [
	STRENGTH,
	MAGIC,
	AGILITY,
	DEFENSE,
	LUCK
]
