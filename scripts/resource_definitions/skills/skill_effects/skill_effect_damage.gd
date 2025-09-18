extends SkillEffect
class_name SkillEffectDamage

const _AFFINITY_DAMAGE_MULT: Dictionary[Affinity.Type, float] = {
	Affinity.NORMAL: 1.0,
	Affinity.WEAK: 1.5,
	Affinity.RESIST: 1.0,
	Affinity.REFLECT: 1.0,
	Affinity.BLOCK: 0.0,
	Affinity.ABSORB: 1.0
}

enum BaseStat {
	STRENGTH,
	MAGIC
}

@export
var power: int = 0
@export
var base_stat: BaseStat = BaseStat.MAGIC
@export
var element: Element.Type

@export
var base_accuracy: float = 0.99
@export
var can_miss: bool = true
@export
var crit_chance: float = 0.01
@export
var can_crit: bool = false

@export
var min_hits_per_target: int = 1
@export
var max_hits_per_target: int = 1

@export
var on_hit_effects: Array[SkillEffect] = []


func apply_effect(p_caster: Character, p_target: Character) -> Array[SkillEffectResult]:
	
	var results: Array[SkillEffectResult] = []
	
	var hits: int = randi_range(min_hits_per_target, max_hits_per_target)
	
	var target_affinity := p_target.get_element_affinity(element)
	
	## TODO: Ailment/elemental related dodging?
	
	var blocked: bool = target_affinity == Affinity.BLOCK
	var final_crit_chance: float = 0.0
	if !blocked and can_crit:
		final_crit_chance = crit_chance * p_caster.get_crit_chance_multiplier()
		final_crit_chance *= p_target.get_crit_avoid_multiplier()
	
	var final_accuracy: float = 0.0
	if can_miss:
		final_accuracy = base_accuracy * p_caster.get_accuracy_multiplier()
		final_accuracy *= p_target.get_dodge_multiplier()
	
	var any_hits: bool = false
	
	for _i in hits:
		
		if can_miss:
			if randf() > final_accuracy:
				results.append(SkillEffectResultDamage.new(
					p_caster, 
					p_target,
					0,
					false,
					true,
					target_affinity,
					false
				))
				continue
		
		if blocked:
			results.append(
				SkillEffectResultDamage.new(
					p_caster, 
					p_target,
					0,
					false,
					false,
					target_affinity,
					true
			))
		
		var did_crit: bool = false
		
		any_hits = target_affinity != Affinity.REFLECT
		
		if can_crit and !blocked:
			did_crit = randf() <= final_crit_chance
		results.append_array(_apply_hit(p_caster, p_target, false, did_crit))
	
	if any_hits:
		for effect in on_hit_effects:
			results.append_array(effect.apply_effect(p_caster, p_target))
	
	return results

func _apply_hit(
	p_caster: Character, 
	p_target: Character, 
	p_is_reflected: bool, 
	p_is_crit: bool
) -> Array[SkillEffectResult]:
	var results : Array[SkillEffectResult] = []
	var target_affinity := p_target.get_element_affinity(element)
	
	if target_affinity == Affinity.REFLECT:
		if p_is_reflected:
			results.append(SkillEffectResultReflected.new(p_caster,p_target))
			results.append_array(_apply_hit(p_caster,p_caster,true,p_is_crit))
			return results
		else:
			results.append(SkillEffectResultDamage.new(
				p_caster,
				p_target,
				0,
				false,
				false,
				target_affinity,
				true
			))
			return results
		
	var base_power: float = float(power)
	var base_multiplier: float = 0.0
	if base_stat == BaseStat.STRENGTH:
		base_multiplier = p_caster.get_strength_damage_multiplier()
	else:
		base_multiplier = p_caster.get_magic_damage_multiplier()
	
	base_multiplier *= p_target.get_defense_damage_multiplier()
	
	base_power *= base_multiplier
	
	base_power *= _AFFINITY_DAMAGE_MULT[target_affinity]
	
	base_power *= p_caster.get_attack_buff_multiplier()
	base_power *= p_target.get_defense_buff_multiplier()
	
	# TODO: Elemental based buffs?
	var damage: int = maxi(1, floori(base_power))
	
	if target_affinity == Affinity.ABSORB:
		p_target.heal(damage)
		results.append(SkillEffectResultHeal.new(
			p_caster,
			p_target,
			damage
		))
	else:
		p_target.deal_damage(damage)
		results.append(SkillEffectResultDamage.new(
			p_caster,
			p_target,
			damage,
			p_is_crit,
			false,
			target_affinity,
			false
		))
	return results


func get_type() -> Type:
	return Type.DAMAGE
