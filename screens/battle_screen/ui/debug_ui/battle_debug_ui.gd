extends Control
class_name BattleDebugUI

var battle_event_bus: BattleEventBusNode
var battle_state_data: BattleStateDataNode

@onready
var round_label: Label = %RoundLabel


func _ready() -> void:
	battle_event_bus.event.connect(_on_event)
	_update_round_number()


func _update_round_number() -> void:
	round_label.text = "Round %d" % battle_state_data.round_number


func _on_event(p_event: BattleEvent):
	
	if p_event is BattleEventRoundNumberChanged:
		_on_round_changed(p_event)


func _on_round_changed(_p_event: BattleEventRoundNumberChanged) -> void:
	_update_round_number()
