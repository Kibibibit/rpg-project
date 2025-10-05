@tool
extends Resource
class_name Skill

enum TargetType {
	SINGLE,
	MULTI,
	RANDOM
}


@export
var name: String:
	set(v):
		resource_name = v
	get:
		return resource_name

@export
var target_type: TargetType = TargetType.SINGLE

@export
var target_self: bool = false
@export
var target_allies: bool = false
@export
var target_enemies: bool = false

@export
var effects: Array[SkillEffect] = []
