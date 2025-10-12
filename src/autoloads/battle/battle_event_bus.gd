extends Node


signal active_changed(new_value: bool)
signal blocked_changed(new_value: bool)
signal event_fired(event: BattleEvent)

var _blocks: Dictionary[int, bool] = {}
var _events: Array[BattleEvent] = []:
	set(v):
		print("changed", v)
		_events = v

var active: bool:
	set(_v):
		pass
	get:
		return process_mode != Node.PROCESS_MODE_DISABLED

func clear() -> void:
	_events.clear()
	_blocks.clear()
	
func activate() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT
	active_changed.emit(active)

func deactivate() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	active_changed.emit(active)

func push_event(event: BattleEvent) -> void:
	_events.push_back(event)

func push_event_to_front(event: BattleEvent) -> void:
	_events.push_front(event)

func add_block(blocker: Object) -> void:
	_blocks[blocker.get_instance_id()] = true
	blocked_changed.emit(true)

func is_blocked() -> bool:
	return not _blocks.is_empty()

func remove_block(blocker: Object) -> void:
	var id: int = blocker.get_instance_id()
	if id in _blocks:
		_blocks.erase(id)
	if not is_blocked():
		blocked_changed.emit(false)

func _process(_delta: float) -> void:
	if not active:
		return
	
	if is_blocked():
		return
	while not _events.is_empty():
		if is_blocked():
			break
		var event: BattleEvent = _events.pop_front()
		if event.type == Event.TYPE_ERROR_NO_TYPE:
			push_error("Event Class: %s has no type!" % event.get_script().get_global_name())
			continue
		print("Firing event: %s" % str(event.type))
		event_fired.emit(event)
