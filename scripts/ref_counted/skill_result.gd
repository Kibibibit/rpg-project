extends RefCounted
class_name SkillResult

# TODO: Implement. Check crit/weakness stuff on add?

var skill: Skill
var effect_results: Array[SkillEffectResult] = []

func _init(p_skill: Skill) -> void:
	skill = p_skill

func add_effect_result(p_effect_result: SkillEffectResult) -> void:
	effect_results.append(p_effect_result)
