extends BattleStateNode
class_name BattleStateUseSkill


var character_id: int
var round_number: int
var skill: Skill
func enter() -> void:
	character_id = context.get_current_character_id()
	round_number = context.round_number
	skill = context.current_skill
		

func activate() -> void:
	if context.get_current_character_id() != character_id or context.round_number != round_number:
		pop()
		return
