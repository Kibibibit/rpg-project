@abstract
extends RefCounted
class_name Context

enum Type {
	BATTLE,
	STATE
}

const _CONTEXT_NAME_MAP: Dictionary[Type, String] = {
	Type.BATTLE: "BattleContext",
	Type.STATE: "StateContext"
}

static func type_to_name(p_context_type: Type) -> String:
	return _CONTEXT_NAME_MAP.get(p_context_type, "UnknownContext")

@abstract
func get_type() -> Type

func get_type_name() -> String:
	return Context.type_to_name(get_type())
