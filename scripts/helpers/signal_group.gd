extends RefCounted
class_name SignalGroup


signal completed

enum Mode {
	ALL,
	ANY
}

var signals: Array[Signal] = []

var mode: Mode = Mode.ALL


func _init(p_mode: Mode, p_signals: Array[Signal]) -> void:
	mode = p_mode
	signals = p_signals.duplicate()
	_connect()


func _connect() -> void:
	for _signal in signals:
		_signal.connect(_on_signal_received.bind(_signal), CONNECT_ONE_SHOT)
	
func _on_signal_received(...args: Array) -> void:
	var sig: Signal = args.back()
	signals.erase(sig)
	if mode == Mode.ANY or signals.size() == 0:
		completed.emit()
		for s in signals:
			s.disconnect(_on_signal_received)
		signals.clear()

static func all(p_signals: Array[Signal]) -> void:
	if p_signals.is_empty():
		return
	var group: SignalGroup = SignalGroup.new(Mode.ALL, p_signals)
	await group.completed

static func any(p_signals: Array[Signal]) -> void:
	var group: SignalGroup = SignalGroup.new(Mode.ANY, p_signals)
	await group.completed
