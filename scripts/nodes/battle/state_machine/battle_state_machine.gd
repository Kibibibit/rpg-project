extends Node
class_name BattleStateMachine

@export
var current_state: BattleStateNode

var state_data: BattleStateData


# TODO: Redo so states emit their exit states, and they can hook into signals themselves

func start_state_machine(p_state_data: BattleStateData) -> void:
	state_data = p_state_data
	current_state.state_enter(state_data)
	SignalBus.Battle.battle_event.connect(update_state_machine)


func update_state_machine(p_event: BattleStateEvent) -> void:
	var next_state := current_state.update_state(state_data, p_event)
	
	if (next_state):
		print("State: %s -> %s" % [current_state.get_class(), next_state.class()])
		current_state.state_exit(state_data)
		current_state = next_state
		current_state.state_enter(state_data)
	
	
