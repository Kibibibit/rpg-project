@abstract
extends Resource
class_name SkillEffect

enum _EffectType {
	DAMAGE,
	CONDITIONAL
}

const Type = _EffectType

@abstract
func get_type() -> Type


@abstract
func apply_effect(_p_caster: Character, _p_target: Character) -> Array[SkillEffectResult]
