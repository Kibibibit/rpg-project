extends Node
class_name BattleManagerNode

@export
var battle_event_bus: BattleEventBusNode
@export
var battle_state_data: BattleStateDataNode
@export
var initial_state: BattleStateInitial
var current_state: BattleStateNode



var battle_started: bool = false

func _ready() -> void:
	_give_dependancies_to_states()
	

func _give_dependancies_to_states() -> void:
	for child in get_children():
		if child is BattleStateNode:
			child.set_state_data(battle_state_data)
			child.set_event_bus(battle_event_bus)

func start_battle(p_player_characters: Array[CharacterState], p_enemy_characters: Array[CharacterState]) -> void:
	initial_state.player_characters = p_player_characters
	initial_state.enemy_characters = p_enemy_characters
	current_state = initial_state
	current_state.enter_state()
	battle_event_bus.emit_event(BattleEventBattleStarted.new())
	battle_started = true

func _process(_delta: float) -> void:
	if not current_state or not battle_started:
		return
	var next_state := current_state.run_state()
	
	if not next_state:
		print("%s returned null state! Terminating..." % current_state.get_state_name())
		battle_started = false
		return
	
	if next_state.id != current_state.id:
		battle_event_bus.emit_event(BattleEventStateChanged.new(current_state.get_type(), next_state.get_type()))
		current_state.exit_state()
		next_state.enter_state()
		current_state = next_state
