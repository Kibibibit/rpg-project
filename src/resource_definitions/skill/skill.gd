@icon("res://resource/icons/skill.png")
extends Resource
class_name Skill

enum TargetScope {
	SELF,
	SINGLE,
	ALL,
	RANDOM
}

@export
var skill_name: String

## If true, this skill's damage effects are boosted by the caster's weapon power
@export var weapon_skill: bool


@export var target_scope: TargetScope = TargetScope.SINGLE

## Does nothing if [target_scope] is SELF
@export var target_allies: bool = false
## Does nothing if [target_scope] is SELF
@export var target_enemies: bool = true


