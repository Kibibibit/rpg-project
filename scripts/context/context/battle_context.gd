class_name BattleContext
extends Context

signal character_added(s_character_id: int)
signal round_number_changed(s_new_round: int)
signal turn_order_changed()

# Character data
var character_map: Dictionary[int, Character] = {}
var battle_actors: Dictionary[int, BattleActor] = {}
var party_parents: Dictionary[Team.Type, PartyParent] = {}
var team_map: Dictionary[int, Team.Type] = {}

var round_number: int = 0

var turn_order: Array[int] = []

var current_skill: Skill = null
var current_targets: Array[int] = []
var skill_result: SkillResult = null

func add_character(p_character: Character, p_team: Team.Type) -> void:
	if character_map.has(p_character.id):
		push_error("Character with ID %d already exists in BattleContext!" % p_character.id)
		return
	character_map[p_character.id] = p_character
	team_map[p_character.id] = p_team
	character_added.emit(p_character.id)

func add_battle_actor(p_character_id: int, p_actor: BattleActor) -> void:
	if not character_map.has(p_character_id):
		push_error("Tried to add an actor for a character that isnt in character map")
		return
	if battle_actors.has(p_character_id):
		push_error("Battle actor for id %d alread exists in BattleContext!" % p_character_id)
	battle_actors[p_character_id] = p_actor

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
		print_stack()
		return -1
	return turn_order[0]

func get_current_character() -> Character:
	var char_id = get_current_character_id()
	if char_id == -1:
		push_error("get_current_character: No current character ID!")
		return null
	return get_character(char_id)
	
func get_character_team(p_character: Character) -> Team.Type:
	if p_character.id in team_map:
		return team_map[p_character.id]
	else:
		push_error("Character %s not in any team!" % p_character.definition.name)
		return Team.NONE

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

func get_valid_targets(p_caster: Character, p_skill: Skill) -> Array[int]:
	var team: Team.Type = get_character_team(p_caster)
	var valid_targets: Array[int] = []
	for character in character_map.values():
		if character.id == p_caster.id and Skill.GROUP_SELF & p_skill.target_group > 0:
			valid_targets.append(character.id)
			continue
		
		var other_team := get_character_team(character)
		if team == other_team and (p_skill.target_group & Skill.GROUP_ALLIES) > 0 and character.id != p_caster.id:
			valid_targets.append(character.id)
		elif team != other_team and p_skill.target_group & Skill.GROUP_ENEMIES > 0:
			valid_targets.append(character.id)
	
	## TODO: Second level of validation (Full health, no ailment. Effect based stuff)
	
	return valid_targets
