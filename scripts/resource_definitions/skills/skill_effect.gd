@abstract
extends Resource
class_name SkillEffect

enum Type {
	DAMAGE,
	DEFEND,
	PASS,
}

@abstract
func get_type() -> Type

@abstract
func apply(p_caster: Character, p_target: Character) -> Array[SkillEffectResult]
