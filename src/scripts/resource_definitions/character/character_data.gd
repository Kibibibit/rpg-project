extends Resource
class_name CharacterData


var definition: CharacterDefinition
var stats: CharacterStats

var hp: int
var mp: int

var strength: int:
	get:
		return stats.strength
var magic: int:
	get:
		return stats.magic
var defense: int:
	get:
		return stats.defense
var agility: int:
	get:
		return stats.agility
var luck: int:
	get:
		return stats.luck


static func from_definition(p_definition: CharacterDefinition) -> CharacterData:
	var data := CharacterData.new()
	data.definition = p_definition
	data.stats = p_definition.base_stats.duplicate()
	data.hp = data.stats.max_hp
	data.mp = data.stats.max_mp
	return data

func get_initiative() -> int:
	return agility

func get_skills() -> Array[Skill]:
	## TODO: Implement level checks
	return definition.innate_skills

func get_element_affinity(p_element: Element.Type) -> Affinity.Type:
	## TODO: implement gear/spell effects
	if p_element in definition.element_affinities:
		return definition.element_affinities[p_element]
	else:
		return Affinity.NORMAL
