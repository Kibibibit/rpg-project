extends BattleEvent
class_name BattleEventTurnOrderChanged

func get_type() -> Type:
	return Type.TURN_ORDER_CHANGED

func get_log_string() -> String:
	return "Turn order was changed"
