extends SkillEffect
class_name SkillEffectDamage

@export
var power: int = 0

@export
var element: Element.Type

@export
var min_hit_count: int = 1
@export
var max_hit_count: int = 1

@export
var damage_base_stat: Stat.Type




func get_type() -> Type:
	return Type.DAMAGE

func _does_reflect(p_character: Character) -> bool:
	return p_character.get_element_affinity(element) == Affinity.REFLECT
	
func _does_block(p_character: Character) -> bool:
	return p_character.get_element_affinity(element) == Affinity.BLOCK

func apply(p_caster: Character, p_target: Character) -> Array[SkillEffectResult]:
	
	var results: Array[SkillEffectResult] = []
	var damage_result := SkillEffectResultDamage.new()
	results.append(damage_result)
	damage_result.caster_id = p_caster.id
	damage_result.intended_target_id = p_target.id
	damage_result.target_id = p_target.id
	
	var actual_target: Character = p_target
	
	var intended_target_reflects: bool = _does_reflect(p_target)
	var actual_target_reflects: bool = intended_target_reflects
	if intended_target_reflects:
		damage_result.target_id = p_caster.id
		actual_target_reflects = _does_reflect(p_caster)
		actual_target = p_caster
		var reflect_event := SkillEffectResultReflect.new()
		reflect_event.caster_id = p_caster.id
		reflect_event.target_id = p_target.id
		results.append(reflect_event)
	
	if _does_block(actual_target) or (intended_target_reflects and _does_block(p_caster)):
		damage_result.blocked = true
	
	var hits := randi_range(min_hit_count, max_hit_count)
	## TODO: Absorb. Should be handled here
	for hit in hits:
		## TODO: Crit and accuracy calculations
		var is_crit: bool = false
		var is_hit: bool = true
		var dmg_result := _apply_hit(
			p_caster, 
			actual_target, 
			is_hit,
			actual_target_reflects, 
			is_crit
		)
		damage_result.hits.append(dmg_result)
		damage_result.any_crit = damage_result.any_crit || is_crit
				
	
	return results

func _apply_hit(
	p_caster: Character, 
	p_target: Character,
	p_is_hit: bool,
	p_is_reflected: bool,
	p_is_crit: bool
) -> DamageResult:
	
	if not p_is_hit:
		return DamageResult.new(
			DamageResult.MISS, false
		)
	if (p_is_reflected and _does_reflect(p_target)) or _does_block(p_target):
		return DamageResult.new(
			DamageResult.BLOCK, false
		)
	## TODO: Actually apply damage
	var damage: int = DamageCalculations.calculate_damage(
		p_caster,
		p_target,
		damage_base_stat,
		power,
		p_is_crit,
		element
	)
	
	p_target.hp = maxi(p_target.hp - damage, 0)
	
	return DamageResult.new(
		damage,p_is_crit
	)
