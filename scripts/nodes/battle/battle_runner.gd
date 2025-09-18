extends Node
class_name BattleRunner

const _LETTERS: Array[String] = [
	"A","B","C","D","E","F","G","H","J","K","L","M","N"
]

signal _on_battle_start_complete_signal
signal _skill_selected_signal
signal _skill_animation_complete_signal

var battle_state: BattleState
var _selected_skill: Skill = null
var _selected_targets: Array[int] = []

@onready
var skill_runner: SkillRunner = $SkillRunner

func _ready() -> void:
	_setup_signals()

func _setup_signals() -> void:
	SignalBus.Battle.skill_selected.connect(_on_skill_selected)
	SignalBus.Battle.skill_animation_complete.connect(_on_skill_animation_complete)
	SignalBus.Battle.on_battle_start_complete.connect(_on_battle_start_complete)

func run_battle(p_player_characters: Array[Character], p_enemy_characters: Array[Character]) -> void:
	
	var battle_over_flag: bool = false
	
	_pre_battle_step(p_player_characters, p_enemy_characters)
	
	await _on_battle_start_complete_signal
	
	# Pre battle dialogue/other scripted stuff can be placed in its own step here
	
	while not _battle_is_over_check():
		_start_round_step()
		while not _round_is_over_check():
			_selected_skill = null
			_selected_targets = []
			var character := _get_next_character_step()
			
			# Round specific dialoge and events can happen in their own step here
			
			_send_skill_request_step(character)
			await _skill_selected_signal
			
			var skill_result := _run_skill_step(_selected_skill, character, _selected_targets)
			_trigger_animation_step(skill_result)
			await _skill_animation_complete_signal
			
			_cleanup_post_skill_step()
			
			if _battle_is_over_check():
				battle_over_flag = true
				break
			
			await get_tree().create_timer(0.3).timeout
				
		if battle_over_flag:
			break
	
	_post_battle_step()

#region Pre Battle Step

func _pre_battle_step(p_player_characters: Array[Character], p_enemy_characters: Array[Character]) -> void:
	print("BATTLE_RUNNER: PreBattle setup")
	
	
	battle_state = BattleState.new(p_player_characters, p_enemy_characters)
	var characters: Array[Character] = p_player_characters.duplicate()
	characters.append_array(p_enemy_characters)
	_update_duplicate_names(characters)
	battle_state.round_number = 0
	
	SignalBus.Battle.emit_do_battle_start(p_player_characters, p_enemy_characters)


func _update_duplicate_names(
	p_characters: Array[Character]
) -> void:
	# TODO: Refactor
	var current_names: Dictionary[String, Array] = {}
	for c in p_characters:
		if not current_names.has(c.character_name):
			current_names[c.character_name] = [] as Array[Character]
		current_names[c.character_name].append(c)
	
	for n in current_names.keys():
		var array: Array = current_names[n]
		if len(array) <= 1:
			continue
		var index: int = 0
		for variant in array:
			var character: Character = variant as Character
			character.character_name += " " + _LETTERS[index]
			index += 1

#endregion Pre Battle Step

func _battle_is_over_check() -> bool:
	## TODO: Implement
	return false

func _start_round_step() -> void:
	
	battle_state.round_number += 1
	print("BATTLE_RUNNER: Start round %d" % battle_state.round_number)
	battle_state.create_turn_order()
	SignalBus.Battle.emit_turn_order_changed(battle_state.turn_order, battle_state.character_is_player_map)

func _round_is_over_check() -> bool:
	return battle_state.turn_order.is_empty()

func _get_next_character_step() -> Character:
	return battle_state.get_next_character()

func _send_skill_request_step(p_character: Character) -> void:
	## TODO: Account for status effects that affect turn/make characters temporarily ai controlled
	print("BATTLE_RUNNER: Sending skill request to %s" % p_character.def.character_name)
	await get_tree().create_timer(0.5).timeout
	if battle_state.get_character_is_player(p_character):
		print("             : Requesting from UI")
		## TODO: Signal frontend
		SignalBus.Battle.emit_request_ai_skill(p_character, battle_state, true)
		pass
	else:
		print("             : Requesting from AI")
		SignalBus.Battle.emit_request_ai_skill(p_character, battle_state, false)

func _run_skill_step(p_skill: Skill, p_character: Character,  p_selected_targets: Array[int]) -> SkillResult:
	print("BATTLE_RUNNER: Running skill %s on " % p_skill.skill_name, p_selected_targets)
	return skill_runner.run_skill(p_skill, p_character, p_selected_targets)

func _trigger_animation_step(p_skill_result: SkillResult) -> void:
	SignalBus.Battle.emit_do_skill_animation(p_skill_result)


func _cleanup_post_skill_step() -> void:
	print("BATTLE_RUNNER: Skill cleanup step!")
	## TODO: Implement

func _post_battle_step() -> void:
	print("BATTLE_RUNNER: Battle over!")
	pass

func _on_skill_selected(p_skill: Skill, p_selected_targets: Array[int]) -> void:
	_selected_skill = p_skill
	_selected_targets = p_selected_targets
	# Deferring it so that the AI controller doesn't call this before the await 
	# has even started
	_skill_selected_signal.emit.call_deferred()

func _on_skill_animation_complete() -> void:
	SignalBus.Battle.emit_turn_order_changed(battle_state.turn_order, battle_state.character_is_player_map)
	_skill_animation_complete_signal.emit.call_deferred()

func _on_battle_start_complete() -> void:
	_on_battle_start_complete_signal.emit.call_deferred()
