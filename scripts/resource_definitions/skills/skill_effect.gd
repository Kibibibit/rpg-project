extends Resource
class_name SkillEffect
## TODO: Make abstract once that's released

enum _EffectType {
	UNKNOWN,
	DAMAGE,
	CONDITIONAL
}

const Type = _EffectType

func get_type() -> Type:
	push_error("Base class of SkillEffect tried to get type!")
	return Type.UNKNOWN


## TODO: Make abstract once possible
func apply_effect(_p_caster: Character, _p_target: Character) -> Array[SkillEffectResult]:
	push_error("Skill effect hasn't implemented apply_effect!")
	return []
