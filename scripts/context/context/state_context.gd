extends Context
class_name StateContext

var state_stack_manager: StateStackManager

func get_type() -> Context.Type:
	return Context.Type.STATE
