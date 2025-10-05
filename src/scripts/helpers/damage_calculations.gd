extends RefCounted
class_name DamageCalculations

const _AFFINITY_MULTIPLIERS : Dictionary[Affinity.Type, float] = {
	Affinity.Type.WEAK: 1.5,
	Affinity.Type.NORMAL: 1.0,
	Affinity.Type.RESIST: 0.5,
	Affinity.Type.BLOCK: 0.0,
	Affinity.Type.REFLECT: 0.0,
	Affinity.Type.ABSORB: 0.0
}

const _BASE_STAT_MULTIPLIER := 0.02
const _DEFENSE_MULTIPLIER := 0.01


## TODO: Make this configurable later
const _CRIT_POWER_MULTIPLIER := 1.5
const _DEFEND_POWER_MULTIPLIER := 0.5


const _RANGE: float = 0.05

static func calculate_damage(
	p_caster: CharacterData,
	p_target: CharacterData,
	p_base_stat: Stat.Type,
	p_base_power: int,
	p_is_crit: bool,
	p_element: Element.Type
) -> int:

	var base_stat: int = p_caster.stats.get_stat(p_base_stat)
	var target_defense: int = p_target.stats.get_stat(Stat.DEFENSE)
	var attack_modifier: float = p_caster.buff_modifiers.get_attack_modifier()
	var defense_modifier: float = p_target.buff_modifiers.get_defense_modifier()

	var damage: float = float(p_base_power) * (1.0+(float(base_stat) * _BASE_STAT_MULTIPLIER))
	damage *= (1.0-float(target_defense) * _DEFENSE_MULTIPLIER)
	
	damage *= 1.0 + randf_range(-_RANGE, _RANGE)

	var affinity := p_target.get_element_affinity(p_element)
	var affinity_multiplier := _AFFINITY_MULTIPLIERS[affinity]

	damage *= affinity_multiplier
	damage *= attack_modifier
	damage *= defense_modifier

	if p_is_crit:
		damage *= _CRIT_POWER_MULTIPLIER
	if p_target.defending:
		damage *= _DEFEND_POWER_MULTIPLIER
	return maxi(floori(damage), 0)
