extends Node
class_name StateStackManager

var started: bool = false

func get_state_context() -> StateContext:
	return ContextManager.get_context(Context.Type.STATE) as StateContext

func get_current_state() -> StateNode:
	if get_child_count() == 0:
		return null
	return get_child(-1) as StateNode

func _ready() -> void:
	ContextManager.create_context(Context.Type.STATE)
	get_state_context().state_stack_manager = self
	
func begin():
	started = true
	if not get_current_state():
		push_error("StateStackManager has no initial state!")
		return
	_connect_signals()
	get_current_state().enter()


func push_state(p_state: StateNode) -> void:
	if get_current_state():
		get_current_state().deactivate()
	_disconnect_signals()
	add_child(p_state)
	get_current_state().enter()
	get_current_state().activate()
	_connect_signals()

func pop_state() -> void:
	if not get_current_state():
		return
	_disconnect_signals()
	get_current_state().deactivate()
	get_current_state().exit()
	get_current_state().queue_free()
	remove_child(get_current_state())
	_connect_signals()
	if get_current_state():
		get_current_state().activate()

func pop_state_until(p_name: String) -> void:
	if not get_current_state():
		return
	_disconnect_signals()
	while get_current_state().name != p_name:
		if not get_current_state():
			push_error("Never found a state with name %s" % p_name)
			return
		get_current_state().exit()
		get_current_state().queue_free()
		remove_child(get_current_state())
		
	_connect_signals()
	if get_current_state():
		get_current_state().activate()
		

func step() -> void:
	if get_current_state() or not started:
		get_current_state().step()

func _disconnect_signals() -> void:
	if get_current_state():
		get_current_state().push_state.disconnect(push_state)
		get_current_state().pop_state.disconnect(pop_state)
		get_current_state().pop_state_until.disconnect(pop_state_until)

func _connect_signals() -> void:
	if get_current_state():
		get_current_state().push_state.connect(push_state)
		get_current_state().pop_state.connect(pop_state)
		get_current_state().pop_state_until.connect(pop_state_until)
