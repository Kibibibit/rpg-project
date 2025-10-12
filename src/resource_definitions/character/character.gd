@icon("res://resource/icons/character.png")
extends Resource
class_name Character

static func from_definition(definition: CharacterDefinition) -> Character:
	var out := Character.new()
	out.def = definition
	out.hp = definition.stats.max_hp
	out.mp = definition.stats.max_mp
	out.stats = definition.stats.duplicate()
	out.buffs = BuffState.new()
	out.resource_name = "Character_%s" % definition.resource_name
	out.unarmed_attack_skill = UIDLookup.load_skill(definition.unarmed_attack_skill)
	for skill_id in definition.innate_skills:
		var skill: Skill = UIDLookup.load_skill(skill_id)
		out.skills.append(skill)
	return out

@export var def: CharacterDefinition

@export var stats: Stats

@export var hp: int
@export var mp: int

## Exported, but should not be saved. It is exported so that it can be seen in the inspector.
@export var buffs: BuffState

@export var unarmed_attack_skill: Skill

@export var skills: Array[Skill] = []
 
## TODO: Add modifiers
func get_stat(stat: Stats.Type) -> int:
	return stats.get_stat(stat)

## TODO: Account for ailments
func get_ai_mode() -> AIMode.Type:
	return AIMode.RANDOM

func get_skills() -> Array[Skill]:
	var out: Array[Skill] = skills.duplicate()
	## TODO: Skills from level ups and gear
	return out
