## ENUM FILE
@abstract
extends EnumBase
class_name Affinity


enum Type {
	NORMAL,
	RESIST,
	WEAK,
	REFLECT,
	ABSORB,
	BLOCK
}

const NORMAL := Type.NORMAL
const RESIST := Type.RESIST
const WEAK := Type.WEAK
const REFLECT := Type.REFLECT
const ABSORB := Type.ABSORB
const BLOCK := Type.BLOCK

const VALUES: Array[Type] = [
	NORMAL,
	RESIST,
	WEAK,
	REFLECT,
	ABSORB,
	BLOCK
]
