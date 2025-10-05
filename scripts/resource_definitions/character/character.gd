extends IdentifiedResource
class_name Character


var definition: CharacterDefinition

var stats: CharacterStats


## Battle Specific stats
var defending: bool = false

var hp: int
var mp: int

var buff_modifiers: BuffModifiers = BuffModifiers.new()


static func from_definition(p_definition: CharacterDefinition) -> Character:
	var state := Character.new()
	state.definition = p_definition
	state.stats = p_definition.base_stats.duplicate()
	state.hp = state.stats.max_hp
	state.mp = state.stats.max_mp
	return state

## This is true if the character has some kind of ailment that 
## prevents them from chosing their own actions.
## TODO: Implement ailment checks
## TODO: Add a function to get the specific kind of ai
func cannot_control() -> bool:
	return false


## Used to determine round ordering
## TODO: Implement ways of modifiying this through gear and skills
func get_initiative() -> int:
	return stats.agility

func get_skills() -> Array[Skill]:
	## TODO: Implement level checks
	return definition.innate_skills

func get_element_affinity(p_element: Element.Type) -> Affinity.Type:
	## TODO: implement gear/spell effects
	if p_element in definition.element_affinities:
		return definition.element_affinities[p_element]
	else:
		return Affinity.NORMAL
