extends Node
class_name BattleLoggerNode

@export
var battle_event_bus: BattleEventBusNode



func _ready() -> void:
	battle_event_bus.event.connect(_on_event)
	
func _on_event(p_event: BattleEvent) -> void:
	print("[EVENT] [%s]\t %s" % [p_event.get_event_name(), p_event.get_log_string()])
