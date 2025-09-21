@abstract
extends Node
class_name BattleStateNode


func state_enter(_p_battle_state: BattleStateData) -> void:
	pass

func state_exit(_p_battle_state: BattleStateData) -> void:
	pass

@abstract
func update_state(p_battle_state: BattleStateData, p_event: BattleStateEvent) -> BattleStateNode
