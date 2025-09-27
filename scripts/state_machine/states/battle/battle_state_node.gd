@abstract
extends StateNode
class_name BattleStateNode

var _context: BattleContext
var context: BattleContext:
	get:
		if _context == null:
			_context = _get_context()
		return _context

func _get_context() -> BattleContext:
	var new_context = ContextManager.get_context(Context.Type.BATTLE)
	if new_context == null:
		push_error("No %s found!" % Context.type_to_name(Context.Type.BATTLE))
		return null
	return new_context as BattleContext
