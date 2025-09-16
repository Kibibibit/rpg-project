extends Resource
class_name CharacterDef

@export
var character_name: String

@export
var base_hp: int
@export
var base_mp: int

@export
var stats: Stats

@export
var element_affinities: Dictionary[Element.Type, Affinity.Type] = {}

@export_category("Skills")
@export
var basic_attack: Skill
@export
var base_skills: Array[Skill] = []


func get_element_affinity(p_element: Element.Type) -> Affinity.Type:
	if p_element in element_affinities:
		return element_affinities[p_element]
	else:
		return Affinity.NORMAL
