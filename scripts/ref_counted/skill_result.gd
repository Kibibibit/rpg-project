extends RefCounted
class_name SkillResult

# TODO: Implement


var effect_results: Array[SkillEffectResult] = []


func add_effect_result(p_effect_result: SkillEffectResult) -> void:
	effect_results.append(p_effect_result)
