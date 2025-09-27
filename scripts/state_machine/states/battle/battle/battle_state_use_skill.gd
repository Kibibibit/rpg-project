extends BattleStateNode
class_name BattleStateUseSkill


var _skill_set: bool = false
var skill: Skill:
	set(v):
		skill = v
		_skill_set = true
	get:
		return skill
var character_id: int
var round_number: int

func enter() -> void:
	character_id = context.get_current_character_id()
	round_number = context.round_number
	if not _skill_set:
		push_error("Tried to enter BattleStateUseSkill without a skill")
		pop()
		

func activate() -> void:
	if context.get_current_character_id() != character_id or context.round_number != round_number:
		pop()
		return
	
