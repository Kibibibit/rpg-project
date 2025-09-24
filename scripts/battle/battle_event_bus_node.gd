extends Node
class_name BattleEventBusNode


signal event(s_event: BattleEvent)
func emit_event(p_event: BattleEvent) -> void:
	event.emit(p_event)

func emit_deferred_event(p_event: BattleEvent) -> void:
	event.emit.call_deferred(p_event)
