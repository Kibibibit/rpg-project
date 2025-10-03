extends BattleStateNode
class_name BattleStateDoEffect


var skill: Skill

var result_played: bool = false

func enter() -> void:
	result_played = false
	SignalBus.Battle.skill_result_finished.connect(_skill_result_finished)

func exit() -> void:
	SignalBus.Battle.skill_result_finished.disconnect(_skill_result_finished)

func activate() -> void:
	SignalBus.Battle.display_skill_result.emit(context.skill_result)

func step() -> void:
	if result_played:
		push(BattleStateTurnEnd.new())

func _skill_result_finished() -> void:
	result_played = true
