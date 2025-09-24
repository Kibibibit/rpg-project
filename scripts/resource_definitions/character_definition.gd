@tool
extends Resource
class_name CharacterDefinition


@export
var name: String:
	set(v):
		resource_name = v
	get:
		return resource_name


@export
var base_stats: CharacterStats = CharacterStats.new()
