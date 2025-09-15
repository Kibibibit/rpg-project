extends RefCounted
class_name BattleSignalBus

## TODO: Look into what signals need to be deferred, or if a system for 
## deferring signals conditionally is needed

signal skill_selected(s_skill: Skill, s_target_ids: Array[int])
func emit_skill_selected(p_skill: Skill, p_target_ids: Array[int]) -> void:
	skill_selected.emit(p_skill, p_target_ids)

signal do_skill_animation(s_skill_result: SkillResult)
func emit_do_skill_animation(p_skill_result: SkillResult) -> void:
	do_skill_animation.emit(p_skill_result)

signal animation_complete()
func emit_animation_complete() -> void:
	animation_complete.emit()

signal request_ai_skill(s_character: Character, s_battle_state: BattleState, s_is_player: bool)
func emit_request_ai_skill(p_character: Character, p_battle_state: BattleState, p_is_player: bool) -> void:
	request_ai_skill.emit(p_character, p_battle_state, p_is_player)
