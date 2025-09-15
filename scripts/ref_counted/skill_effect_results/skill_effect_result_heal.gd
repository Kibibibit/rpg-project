extends SkillEffectResult
class_name SkillEffectResultHeal


var caster: Character
var target: Character
var amount: int

func _init(p_caster: Character, p_target: Character, p_amount: int) -> void:
	caster = p_caster
	target = p_target
	amount = p_amount
	
func get_type() -> Type:
	return Type.HEAL
