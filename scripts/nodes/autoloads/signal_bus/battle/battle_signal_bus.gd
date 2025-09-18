extends RefCounted
class_name BattleSignalBus

## TODO: Look into what signals need to be deferred, or if a system for 
## deferring signals conditionally is needed

var UI := BattleUISignalBus.new()

signal do_battle_start(s_player_party: Array[Character], s_enemy_party: Array[Character])
func emit_do_battle_start(p_player_party: Array[Character], p_enemy_party: Array[Character]) -> void:
	do_battle_start.emit(p_player_party, p_enemy_party)


signal on_battle_start_complete()
func emit_on_battle_start_complete() -> void:
	on_battle_start_complete.emit()

signal skill_selected(s_skill: Skill, s_target_ids: Array[int])
func emit_skill_selected(p_skill: Skill, p_target_ids: Array[int]) -> void:
	skill_selected.emit(p_skill, p_target_ids)

signal do_skill_animation(s_skill_result: SkillResult)
func emit_do_skill_animation(p_skill_result: SkillResult) -> void:
	do_skill_animation.emit(p_skill_result)

signal skill_animation_complete()
func emit_skill_animation_complete() -> void:
	skill_animation_complete.emit()

signal request_ai_skill(s_character: Character, s_battle_state: BattleState, s_is_player: bool)
func emit_request_ai_skill(p_character: Character, p_battle_state: BattleState, p_is_player: bool) -> void:
	request_ai_skill.emit(p_character, p_battle_state, p_is_player)

signal turn_order_changed(s_character_ids: Array[int], s_is_player_map: Dictionary[int, bool])
func emit_turn_order_changed(p_character_ids: Array[int], p_is_player_map: Dictionary[int, bool]) -> void:
	turn_order_changed.emit(p_character_ids, p_is_player_map)
