extends RefCounted
class_name SkillEffectResult

## TODO: Make Abstract once possible


enum _SkillEffectResultType {
	UNKNOWN,
	CONSUMED_RESOURCE,
	DAMAGE,
	HEAL,
	REFLECTED
}

const Type = _SkillEffectResultType


func get_type() -> Type:
	## TODO: Make abstract once possible
	push_error("Abstract skill effect result was called!")
	return Type.UNKNOWN
