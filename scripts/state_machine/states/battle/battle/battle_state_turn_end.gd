extends BattleStateNode
class_name BattleStateTurnEnd


func enter() -> void:
	context.skill_result = null
	context.current_skill = null
	context.current_targets = []

func step() -> void:
	pop_until(BattleStateRound.NAME)
