extends Node
class_name SkillRunner

## Just handles the initial skill logic to prevent circular dependancy
## between `Skill` and `Character`


func run_skill(p_skill: Skill, p_character: Character, p_target_ids: Array[int]) -> SkillResult:
	
	var targets: Array[Character] = []
	for target_id in p_target_ids:
		targets.append(Character.from_id(target_id))
	
	print("SKILL_RUNNER: Character<%s> using Skill<%s> on target Characters<[%s]>" % [
		p_character.def.character_name,
		p_skill.skill_name,
		targets.reduce(func(acc: String, p_c: Character): return acc + ("" if acc.is_empty() else ", ") + p_c.def.character_name, "")
	])
	
	var result := SkillResult.new()
	
	var pre_cost: int = p_character.get_resource_total(p_skill.cost_type)
	
	p_character.apply_cost(p_skill)
	
	var post_cost: int = p_character.get_resource_total(p_skill.cost_type)
	
	result.add_effect_result(SkillEffectResultConsumedResource.new(p_character, pre_cost, post_cost, p_skill.cost_type))
	
	var effect_results: Array[SkillEffectResult] = []
	
	if p_skill.target_type == Skill.TargetType.RANDOM:
		var cast_count := p_skill.min_random_targets
		if p_skill.min_random_targets != p_skill.max_random_targets:
			cast_count = randi_range(p_skill.min_random_targets, p_skill.max_random_targets)
		
		for _i in cast_count:
			var target : Character = targets.pick_random() as Character
			for effect in p_skill.effects:
				effect_results.append_array(effect.apply_effect(p_character, target))
	else:
		for effect in p_skill.effects:
			for target in targets:
				effect_results.append_array(effect.apply_effect(p_character, target))
		
	
	for r in effect_results:
		result.add_effect_result(r)
	
	return result
