@tool
extends IdentifiedResource
class_name Skill

enum TargetType {
	SINGLE,
	MULTI,
	RANDOM
}

const GROUP_SELF: int = 1
const GROUP_ALLIES: int = 2
const GROUP_ENEMIES: int = 4

@export
var name: String:
	set(v):
		resource_name = v
	get:
		return resource_name

@export
var target_type: TargetType = TargetType.SINGLE
@export_flags("Self", "Allies", "Enemies")
var target_group: int = 0

@export
var effects: Array[SkillEffect] = []
@export
var spell_effect: PackedScene

## TODO: Find a better way to load this
## TODO: Chose a better name
func get_spell_effect() -> SpellEffectNode:
	if not spell_effect:
		return preload("uid://m7ynnjm67eot").instantiate() as SpellEffectNode
	return spell_effect.instantiate() as SpellEffectNode
