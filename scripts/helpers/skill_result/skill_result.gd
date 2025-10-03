extends RefCounted
class_name SkillResult

var effect_results: Array[SkillEffectResult] = []
var skill: Skill



## TODO: Implement phases
func get_phase_one_effects() -> Array[SkillEffectResult]:
	return effect_results
