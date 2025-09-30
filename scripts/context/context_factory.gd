extends RefCounted
class_name ContextFactory


const ContextScripts: Dictionary[Context.Type, Script] = {
	Context.Type.BATTLE: preload("uid://cm7b31s7uwwcl"),
	Context.Type.STATE: preload("uid://c4cyq4d732kjt")
}

func create_context(p_context_type: Context.Type) -> Context:
	var script = ContextScripts.get(p_context_type, null)
	if script == null:
		push_error("No script found for context type %s" % Context.type_to_name(p_context_type))
		return null
	var context = script.new()
	if not context is Context:
		push_error("Script for context type %s does not extend Context" % Context.type_to_name(p_context_type))
		return null
	return context
