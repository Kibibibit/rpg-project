extends Node
class_name TurnOrderManager


# Exported for debugging
@export
var turn_order: Array[Character] = []


var _get_all_characters_callable: Callable


func _ready() -> void:
	BattleEventBus.event_fired.connect(_on_battle_event)



func _on_battle_event(event: BattleEvent) -> void:
	if event is BattleEventDoNextTurn:
		_do_next_turn()
	

func _do_next_turn() -> void:
	if turn_order.size() == 0:
		# Starting a new round
		_create_turn_order()
		# TODO: Emit new round event?
	
	var current_character: Character = turn_order.pop_front()
	BattleEventBus.push_event(BattleEventGetCharAction.new(current_character))

func _create_turn_order() -> void:
	turn_order = get_all_characters().duplicate()
	turn_order.sort_custom(func(a: Character, b: Character) -> int:
		return Initiative.calculate(b) - Initiative.calculate(a)
	)

func get_all_characters() -> Array[Character]:
	if _get_all_characters_callable != null:
		return _get_all_characters_callable.call()
	else:
		push_warning("No callable set for getting all characters in TurnOrderManager")
		return []
