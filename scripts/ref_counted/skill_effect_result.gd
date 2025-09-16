@abstract
extends RefCounted
class_name SkillEffectResult

enum _SkillEffectResultType {
	CONSUMED_RESOURCE,
	DAMAGE,
	HEAL,
	REFLECTED
}

const Type = _SkillEffectResultType

@abstract
func get_type() -> Type
