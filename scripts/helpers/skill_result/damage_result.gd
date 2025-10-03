extends RefCounted
class_name DamageResult 

const MISS: int = -1
const BLOCK: int = -2

var damage: int
var was_crit: bool

func _init(p_damage: int, p_was_crit: bool) -> void:
	damage = p_damage
	was_crit = p_was_crit
