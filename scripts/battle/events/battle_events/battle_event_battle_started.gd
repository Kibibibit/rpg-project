extends BattleEvent
class_name BattleEventBattleStarted

func get_type() -> Type:
	return Type.STARTED

func get_log_string() -> String:
	return "Starting battle!"
