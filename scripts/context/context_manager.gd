extends Node



var contexts: Dictionary[Context.Type, Context] = {}

var _context_factory: ContextFactory = ContextFactory.new()

func get_context(p_context_type: Context.Type) -> Context:
	return contexts.get(p_context_type, null)

func create_context(p_context_type: Context.Type) -> void:
	if contexts.has(p_context_type):
		push_error("Context of type %s already exists!" % Context.type_to_name(p_context_type))
		return
	
	var context = _context_factory.create_context(p_context_type)
	if context == null:
		push_error("Failed to create context of type %s" % Context.type_to_name(p_context_type))
		return
	
	contexts[context.get_type()] = context

func destroy_context(p_context_type: Context.Type) -> void:
	if not contexts.has(p_context_type):
		push_error("Context of type %s does not exist!" % Context.type_to_name(p_context_type))
		return
	contexts.erase(p_context_type)
