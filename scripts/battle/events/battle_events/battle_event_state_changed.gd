extends BattleEvent
class_name BattleEventStateChanged


var from_state: BattleStateNode.Type
var to_state: BattleStateNode.Type

func get_type() -> Type:
	return Type.STATE_CHANGED

func get_log_string() -> String:
	return "State changed from %s -> %s" % [
		BattleStateNode.get_state_name_from_type(from_state),
		BattleStateNode.get_state_name_from_type(to_state),
	]

func _init(p_from_state: BattleStateNode.Type, p_to_state: BattleStateNode.Type) -> void:
	super()
	from_state = p_from_state
	to_state = p_to_state


	
