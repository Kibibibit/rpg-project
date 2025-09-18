extends RefCounted
class_name BattleUISignalBus


signal on_character_ready(s_character_id: int)
func emit_on_character_ready(p_character_id: int) -> void:
	on_character_ready.emit(p_character_id)

signal on_party_ready(s_is_player: bool)
func emit_on_party_ready(p_is_player: bool) -> void:
	on_party_ready.emit(p_is_player)

signal request_skill_animation(
	s_id: int,
	s_skill: Skill,
	s_caster: Character, 
	s_target: Character, 
	s_effect: SkillEffectResult
)
func emit_request_skill_animation(
	p_skill: Skill,
	p_result: SkillResult
) -> void:
	request_skill_animation.emit(p_skill, p_result)

signal skill_animation_complete(s_skill: Skill)
func emit_skill_animation_complete(p_skill: Skill) -> void:
	skill_animation_complete.emit(p_skill)

signal show_damage_number(s_character_id: int, s_amount: float)
func emit_show_damage_number(p_character_id: int, p_amount: float) -> void:
	show_damage_number.emit(p_character_id, p_amount)
