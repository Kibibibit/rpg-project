extends Node
class_name BattleStateDataNode


var character_map: Dictionary[int, CharacterState] = {}
var character_team_map: Dictionary[int, Team.Type] = {}

var round_number: int = 0
var turn_order: Array[int] = []




func get_character_ids() -> Array[int]:
	var out: Array[int] = []
	for c_id in character_map.keys():
		out.append(c_id)
	return out

func get_character_by_id(p_character_id: int) -> CharacterState:
	if (p_character_id in character_map):
		return character_map[p_character_id]
	else:
		push_error("Could not find character with id %d" % p_character_id)
		return null
