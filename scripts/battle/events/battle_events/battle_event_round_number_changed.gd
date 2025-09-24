extends BattleEvent
class_name BattleEventRoundNumberChanged

func get_type() -> Type:
	return Type.ROUND_NUMBER_CHANGED

func get_log_string() -> String:
	return "Round number changed"
