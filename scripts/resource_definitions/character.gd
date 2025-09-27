extends IdentifiedResource
class_name Character


var definition: CharacterDefinition

var stats: CharacterStats

static func from_definition(p_definition: CharacterDefinition) -> Character:
	var state := Character.new()
	state.definition = p_definition
	state.stats = p_definition.base_stats.duplicate()
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
