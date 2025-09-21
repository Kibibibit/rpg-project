@abstract
extends RefCounted
class_name BattleStateEvent


enum Type {
	PRE_BATTLE_ANIMATION_COMPLETE
}


@abstract
func get_type() -> Type
