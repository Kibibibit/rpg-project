extends BattleStateNode
class_name BattleStateUseSkill


var character_id: int
var round_number: int
var skill: Skill
func enter() -> void:
	character_id = context.get_current_character_id()
	round_number = context.round_number
	skill = context.current_skill
	context.skill_result = null
		


func step() -> void:
	var result: SkillResult = SkillResult.new()
	result.skill = context.current_skill
	## TODO: random skills
	for target in context.current_targets:
		for effect in skill.effects:
			result.effect_results.append_array(
				effect.apply(
					context.get_current_character(),
					context.get_character(target)
				)
			)
	context.skill_result = result
	push(BattleStateDoEffect.new())
