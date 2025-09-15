extends RefCounted
class_name BattleState

var player_characters: Dictionary[int, Character] = {}
var enemy_characters: Dictionary[int, Character] = {}
var character_is_player_map: Dictionary[int, bool] = {}

var round_number: int = 0
var turn_order: Array[int] = []

func _init(p_player_characters: Array[Character], p_enemy_characters: Array[Character]) -> void:
	for c in p_player_characters:
		var c_id: int = c.get_instance_id()
		player_characters[c_id] = c
		character_is_player_map[c_id] =  true
	for c in p_enemy_characters:
		var c_id: int = c.get_instance_id()
		enemy_characters[c_id] = c
		character_is_player_map[c_id] = false

func get_player_character_ids() -> Array[int]:
	var out: Array[int] = []
	for key in player_characters.keys():
		out.append(key as int)
	return out

func get_enemy_character_ids() -> Array[int]:
	var out: Array[int] = []
	for key in enemy_characters.keys():
		out.append(key as int)
	return out

func get_all_character_ids() -> Array[int]:
	var out: Array[int] = []
	out.append_array(get_player_character_ids())
	out.append_array(get_enemy_character_ids())
	return out

func create_turn_order() -> void:
	turn_order = get_all_character_ids()
	turn_order.sort_custom(_sort_characters_by_initiative)

func get_character_by_id(p_id: int) -> Character:
	if character_is_player_map.has(p_id):
		if character_is_player_map[p_id]:
			return player_characters[p_id]
		else:
			return enemy_characters[p_id]
	return null

func _sort_characters_by_initiative(a_id: int, b_id: int) -> bool:
	var a_initiative: int = get_character_by_id(a_id).get_initiative()
	var b_initiative: int = get_character_by_id(b_id).get_initiative()
	return a_initiative > b_initiative
	
func get_next_character() -> Character:
	var c_id: int = turn_order.pop_front()
	return get_character_by_id(c_id)

func get_character_is_player(p_character: Character) -> bool:
	return character_is_player_map[p_character.get_instance_id()]
