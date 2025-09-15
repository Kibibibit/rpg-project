extends SkillEffectResult
class_name SkillEffectResultConsumedResource


var character: Character
var from: int
var to: int
var resource: ResourceCost.Type


func _init(p_character: Character, p_from: int, p_to: int, p_resource: ResourceCost.Type) -> void:
	character = p_character
	from = p_from
	to = p_to
	resource = p_resource

func get_type() -> Type:
	return Type.CONSUMED_RESOURCE
