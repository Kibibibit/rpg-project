extends BattleEvent
class_name BattleEventGetAIAction

var character: Character

func _init(p_character: Character) -> void:
	character = p_character

func get_type() -> StringName:
	return BattleEvent.TYPE_GET_AI_ACTION
