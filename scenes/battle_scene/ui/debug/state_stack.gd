extends Label


func _process(_delta: float) -> void:
	if is_visible_in_tree():
		var context: StateContext = ContextManager.get_context(Context.Type.STATE) as StateContext
		if not context:
			text = "State context missing!"
			return
		var state_names: Array[String] = ["State Stack:"]
		for child in context.state_stack_manager.get_children():
			state_names.append(child.name)
		
		text = "\n".join(state_names)
	
