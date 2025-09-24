extends BattleStateNode
class_name BattleStateStartRound

@export
var start_turn_state: BattleStateNode

func get_type() -> Type:
	return Type.START_ROUND

func run_state() -> BattleStateNode:
	_determine_round_order()
	battle_state_data.round_number += 1
	battle_event_bus.emit_event(BattleEventRoundNumberChanged.new())
	
	return start_turn_state

func _determine_round_order() -> void:
	var character_ids: Array[int] = battle_state_data.get_character_ids()
	
	character_ids.sort_custom(func(a, b):
		return _sort_characters(a,b)
	)
	
	battle_state_data.turn_order = character_ids.duplicate()
	battle_event_bus.emit_event(BattleEventTurnOrderChanged.new())


func _sort_characters(p_id_a: int, p_id_b: int) -> bool:
	var char_a := battle_state_data.get_character_by_id(p_id_a)
	var char_b := battle_state_data.get_character_by_id(p_id_b)
	
	return char_a.get_initiative() < char_b.get_initiative()
