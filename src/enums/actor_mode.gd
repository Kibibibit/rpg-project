## ENUM FILE
@abstract
extends EnumBase
class_name ActorMode


enum Type {
	PLAYER,
	AI
}

const PLAYER := Type.PLAYER
const AI := Type.AI

const VALUES: Array[Type] = [
	PLAYER,
	AI
]
