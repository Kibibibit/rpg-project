extends RefCounted
class_name BuffModifiers

## TODO: Possibly set these in a global config file later
const SPEED_POSITIVE_MODIFIER := 0.125
const SPEED_NEGATIVE_MODIFIER := 0.1
const ACCURACY_NEGATIVE_MODIFIER := 0.1
const ATTACK_POSITIVE_MODIFIER := 0.125
const ATTACK_NEGATIVE_MODIFIER := 0.1
const DEFENSE_POSITIVE_MODIFIER := 0.125
const DEFENSE_NEGATIVE_MODIFIER := 0.1
const CRIT_POSITIVE_MODIFIER := 0.125
const CRIT_NEGATIVE_MODIFIER := 0.1



var speed_buff: int = 0
var attack_buff: int = 0
var defense_buff: int = 0
var crit_buff: int = 0



func _get_modifier(buff: int, positive_modifier: float, negative_modifier: float) -> float:
	if buff > 0:
		return 1.0 + (buff * positive_modifier)
	elif buff < 0:
		return (1.0 - (abs(buff) * negative_modifier))
	else:
		return 1.0

func get_accuracy_modifier() -> float:
	return _get_modifier(speed_buff, SPEED_POSITIVE_MODIFIER, SPEED_NEGATIVE_MODIFIER)

func get_evasion_modifier() -> float:
	return _get_modifier(speed_buff, SPEED_NEGATIVE_MODIFIER, SPEED_POSITIVE_MODIFIER)

func get_attack_modifier() -> float:
	return _get_modifier(attack_buff, ATTACK_POSITIVE_MODIFIER, ATTACK_NEGATIVE_MODIFIER)

func get_defense_modifier() -> float:
	return _get_modifier(defense_buff, DEFENSE_NEGATIVE_MODIFIER, DEFENSE_POSITIVE_MODIFIER)

func get_crit_modifier() -> float:
	return _get_modifier(crit_buff, CRIT_POSITIVE_MODIFIER, CRIT_NEGATIVE_MODIFIER)
