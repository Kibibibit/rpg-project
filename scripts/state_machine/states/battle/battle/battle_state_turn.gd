extends BattleStateNode
class_name BattleStateTurn

var character_id: int


func enter() -> void:
	character_id = context.get_current_character_id()
	SignalBus.Battle.turn_started.emit(character_id)

func step() -> void:
	
	var control_mode: CharacterControlMode.Type = context.get_control_mode(character_id)
	
	match control_mode:
		CharacterControlMode.PLAYER:
			push(BattleStatePlayerAction.new())
		_:
			push(BattleStateAIAction.new())
