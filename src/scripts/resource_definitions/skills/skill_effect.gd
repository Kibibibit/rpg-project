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
func apply(p_caster: CharacterData, p_target: CharacterData) -> void
