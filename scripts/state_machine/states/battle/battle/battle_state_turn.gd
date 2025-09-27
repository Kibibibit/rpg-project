extends BattleStateNode
class_name BattleStateTurn

var character_id: int
var round_number: int
func enter() -> void:
	round_number = context.round_number
	character_id = context.get_current_character_id()
	SignalBus.Battle.turn_started.emit(character_id)

func step() -> void:
	
	var control_mode: CharacterControlMode.Type = context.get_control_mode(character_id)
	
	match control_mode:
		CharacterControlMode.PLAYER:
			push( BattleStatePlayerAction.new())
		_:
			push(battleStateAIAction.new())




func activate() -> void:
	if context.get_current_character_id() != character_id or context.round_number != round_number:
		pop()
