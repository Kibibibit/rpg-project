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
