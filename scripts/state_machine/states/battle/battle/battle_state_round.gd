extends BattleStateNode
class_name BattleStateRound

const NAME = "BattleStateRound"

var round_started: bool = false

func enter() -> void:
	context.advance_round_number()
	SignalBus.Battle.round_started.emit(context.round_number)
	context.create_turn_order()


func step() -> void:
	if not round_started:
		round_started = true
	else:
		context.advance_to_next_turn()

	if context.has_round_ended():
		pop()
	else:
		push(BattleStateTurn.new())
