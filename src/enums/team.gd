## ENUM FILE
@abstract
extends EnumBase
class_name Team


enum Type {
	PLAYER,
	ENEMY
}

const PLAYER := Type.PLAYER
const ENEMY := Type.ENEMY

const VALUES: Array[Type] = [
	PLAYER,
	ENEMY
]
