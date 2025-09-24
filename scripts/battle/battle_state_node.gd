@abstract
extends Node
class_name BattleStateNode


enum Type {
	INITIAL,
	START_ROUND,
	START_TURN
}

static var _names: Dictionary[Type, String] = {}

func _register_name() -> void:
	_names[get_type()] = get_script().get_global_name()


static func get_state_name_from_type(p_type: Type) -> String:
	return _names[p_type]

var battle_state_data: BattleStateDataNode
var battle_event_bus: BattleEventBusNode

## The current instance id of this object.
## Note that these are not persisted between runs,
## and should only be used for runtime checks
var id: int:
	get:
		return get_instance_id()


func set_state_data(p_battle_state_data: BattleStateDataNode) -> void:
	battle_state_data = p_battle_state_data
func set_event_bus(p_battle_event_bus: BattleEventBusNode) -> void:
	battle_event_bus = p_battle_event_bus
	battle_event_bus.event.connect(_on_event)


func _init() -> void:
	_register_name()

func _exit_tree() -> void:
	battle_event_bus.event.disconnect(_on_event)

@abstract
func get_type() -> Type

func get_state_name() -> String:
	return get_state_name_from_type(get_type())

func enter_state() -> void:
	pass
	
@abstract
func run_state() -> BattleStateNode

func exit_state() -> void:
	pass

func _on_event(_p_event: BattleEvent) -> void:
	pass
