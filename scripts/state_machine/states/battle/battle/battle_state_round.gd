extends BattleStateNode
class_name BattleStateRound


func enter() -> void:
	context.advance_round_number()
	SignalBus.Battle.round_started.emit(context.round_number)
	context.create_turn_order()


func step() -> void:
	if context.has_round_ended():
		pop()
	else:
		push(BattleStateTurn.new())
