extends RefCounted
class_name StatModifiers

## TODO: Ailment and crit chance modifiers

const POSITIVE_ATTACK_STEP: float = 0.15
const NEGATIVE_ATTACK_STEP: float = 0.10
const POSITIVE_DEFENSE_STEP: float = 0.15
const NEGATIVE_DEFENSE_STEP: float = 0.10
const POSITIVE_SPEED_STEP: float = 0.15
const NEGATIVE_SPEED_STEP: float = 0.10

var attack_modifier: int = 0
var defense_modifier: int = 0
var speed_modifier: int = 0

func reset() -> void:
	attack_modifier = 0
	defense_modifier = 0
	speed_modifier = 0

func _get_modifier(
	p_modifier: int, 
	p_positive_step: float, 
	p_negative_step: float
) -> float:
	if p_modifier < 0:
		return -1.0 * p_negative_step * p_modifier
	elif p_modifier > 0:
		return p_positive_step * p_modifier
	else:
		return 0.0

func get_attack_multiplier() -> float:
	return 1.0 + _get_modifier(attack_modifier, POSITIVE_ATTACK_STEP, NEGATIVE_ATTACK_STEP)

func get_defense_multiplier() -> float:
	return 1.0 - _get_modifier(defense_modifier, POSITIVE_DEFENSE_STEP, NEGATIVE_DEFENSE_STEP)

func get_speed_accuracy_multiplier() -> float:
	return 1.0 + _get_modifier(speed_modifier, POSITIVE_SPEED_STEP, NEGATIVE_SPEED_STEP)

func get_speed_evasion_multiplier() -> float:
	return 1.0 - _get_modifier(speed_modifier, POSITIVE_SPEED_STEP, NEGATIVE_SPEED_STEP)
