## ENUM FILE
@abstract
extends EnumBase
class_name Team


enum Type {
	NONE,
	PLAYER,
	ENEMY
}

const NONE := Type.NONE
const PLAYER := Type.PLAYER
const ENEMY := Type.ENEMY

const VALUES: Array[Type] = [
	NONE,
	PLAYER,
	ENEMY
]
