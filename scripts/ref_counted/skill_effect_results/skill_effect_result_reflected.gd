extends SkillEffectResult
class_name SkillEffectResultReflected


var caster: Character
var target: Character

func _init(p_caster: Character, p_target: Character) -> void:
	caster = p_caster
	target = p_target

func get_type() -> Type:
	return Type.REFLECTED
