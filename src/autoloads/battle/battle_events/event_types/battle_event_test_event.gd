extends BattleEvent
class_name BattleEventTestEvent

func get_type() -> StringName:
	return BattleEvent.TYPE_TEST_EVENT


var data: String

func _init(p_data: String) -> void:
	data = p_data
