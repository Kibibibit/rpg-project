extends SkillEffect
class_name SkillEffectDefend

func get_type() -> Type:
	return Type.DEFEND


func apply(p_caster: Character, p_target: Character) -> Array[SkillEffectResult]:
	if p_caster.id != p_target.id:
		push_warning("For some reason, %s is defending %s, which is not themself." % [
			p_caster.name, p_target.name
		])
	var result := SkillEffectResultDefend.new()
	result.caster_id = p_caster.id
	result.target_id = p_target.id
	p_target.defending = true
	return [result]
	
