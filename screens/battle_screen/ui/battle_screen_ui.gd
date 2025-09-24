extends Control
class_name BattleScreenUI

@export
var battle_event_bus: BattleEventBusNode
@export
var battle_state_data: BattleStateDataNode

@export
var debug_ui: BattleDebugUI

func _enter_tree() -> void:
	_give_dependancies_to_children()
	


func _give_dependancies_to_children() -> void:
	debug_ui.battle_event_bus = battle_event_bus
	debug_ui.battle_state_data = battle_state_data
