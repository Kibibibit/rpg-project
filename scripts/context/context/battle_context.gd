class_name BattleContext
extends Context

signal character_added(s_character_id: int)
signal round_number_changed(s_new_round: int)
signal turn_order_changed()

# Character data
var character_map: Dictionary[int, Character] = {}
var team_map: Dictionary[int, Team.Type] = {}

var round_number: int = 0

var turn_order: Array[int] = []

func add_character(p_character: Character, p_team: Team.Type) -> void:
	if character_map.has(p_character.id):
		push_error("Character with ID %d already exists in BattleContext!" % p_character.id)
		return
	character_map[p_character.id] = p_character
	team_map[p_character.id] = p_team
	character_added.emit(p_character.id)

func add_characters(p_characters: Array, p_team: Team.Type) -> void:
	for character in p_characters:
		add_character(character, p_team)

func get_all_character_ids() -> Array[int]:
	var out: Array[int] = []
	for char_id in character_map.keys():
		out.append(char_id)
	return out

func get_character(p_id: int) -> Character:
	if not character_map.has(p_id):
		push_error("get_character: No character with ID %d found in BattleContext!" % p_id)
		return null
	return character_map.get(p_id)

func advance_round_number() -> void:
	round_number += 1
	round_number_changed.emit(round_number)

func create_turn_order() -> void:
	turn_order.clear()
	turn_order = get_all_character_ids()
	sort_turn_order()

func sort_turn_order() -> void:
	turn_order.sort_custom(func(a, b): 
		var char_a: Character = character_map[a]
		var char_b: Character = character_map[b]
		return char_a.get_initiative() - char_b.get_initiative()
	)
	turn_order_changed.emit()

func get_current_character_id() -> int:
	if turn_order.is_empty():
		push_error("get_current_character_id: Turn order is empty!")
		return -1
	return turn_order[0]

func get_current_character() -> Character:
	var char_id = get_current_character_id()
	if char_id == -1:
		push_error("get_current_character: No current character ID!")
		return null
	return get_character(char_id)

func advance_to_next_turn() -> void:
	if turn_order.is_empty():
		push_error("advance_to_next_turn: Turn order is empty!")
		return
	turn_order.pop_front()
	turn_order_changed.emit()

func has_team_lost(_p_team: Team.Type) -> bool:
	## TODO: implement
	return false

func has_round_ended() -> bool:
	return turn_order.is_empty()

func get_type() -> Type:
	return Type.BATTLE

func get_control_mode(_p_character_id: int) -> CharacterControlMode.Type:
	## TODO: implement
	return CharacterControlMode.Type.PLAYER
