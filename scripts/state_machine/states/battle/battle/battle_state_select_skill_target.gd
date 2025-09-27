extends BattleStateNode
class_name BattleStateSelectSkillTarget




var character_id: int
var round_number: int
var skill: Skill

func enter() -> void:
	character_id = context.get_current_character_id()
	round_number = context.round_number
	skill = context.current_skill
	if not skill:
		push_error("Tried to enter BattleStateSelectSkillTarget without a skill")


func activate() -> void:
	if context.get_current_character_id() != character_id or context.round_number != round_number:
		pop()
		return
	

func step() -> void:
	## TODO: Target selection logic

	var use_skill_state := BattleStateUseSkill.new()
	use_skill_state.skill = skill

	push(use_skill_state)