extends IdentifiedResource
class_name CharacterState


var definition: CharacterDefinition

var stats: CharacterStats

## This is false if the character has some kind of ailment that 
## prevents them from chosing their own actions.
## TODO: Implement ailment checks
## TODO: Add a function to get the specific kind of ai
func can_be_controlled_by_player() -> bool:
	return true


## Used to determine round ordering
## TODO: Implement ways of modifiying this through gear and skills
func get_initiative() -> int:
	return stats.agility
