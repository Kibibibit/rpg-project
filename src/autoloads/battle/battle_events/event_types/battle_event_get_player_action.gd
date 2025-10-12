extends BattleEvent
class_name BattleEventGetPlayerAction

var character: Character

func get_type() -> StringName:
	return BattleEvent.TYPE_GET_PLAYER_ACTION


func _init(p_character: Character) -> void:
	character = p_character
