@tool
extends IdentifiedResource
class_name Skill

@export
var name: String:
	set(v):
		resource_name = v
	get:
		return resource_name
