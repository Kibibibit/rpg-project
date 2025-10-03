@abstract
extends RefCounted
class_name SkillEffectResult

enum Type {
	DEFEND,
	PASS,
	DAMAGE,
	REFLECT
}

var caster_id: int
var target_id: int

@abstract
func get_type() -> Type
