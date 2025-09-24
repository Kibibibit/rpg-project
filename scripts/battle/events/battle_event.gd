@abstract
extends RefCounted
class_name BattleEvent



enum Type {
	STARTED,
	STATE_CHANGED,
	TURN_ORDER_CHANGED,
	ROUND_NUMBER_CHANGED
}

static var _names: Dictionary[Type, String] = {}

func _register_name() -> void:
	_names[get_type()] = get_script().get_global_name()

func get_event_name() -> String:
	return _names[get_type()]

func _init() -> void:
	_register_name()

@abstract
func get_type() -> Type

@abstract
func get_log_string() -> String
