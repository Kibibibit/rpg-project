extends RefCounted
class_name Affinity

enum _AffinityType {
	NORMAL,
	WEAK,
	RESIST,
	BLOCK,
	REFLECT,
	ABSORB
}

const Type = _AffinityType

const NORMAL := Type.NORMAL
const WEAK := Type.WEAK
const BLOCK := Type.BLOCK
const RESIST := Type.RESIST
const REFLECT := Type.REFLECT
const ABSORB := Type.ABSORB
