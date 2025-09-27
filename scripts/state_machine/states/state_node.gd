@abstract
extends Node
class_name StateNode

@warning_ignore("unused_signal")
signal push_state(s_new_state: StateNode)
@warning_ignore("unused_signal")
signal pop_state()

func _ready() -> void:
	name = get_script().get_global_name()

func enter() -> void:
	pass

func activate() -> void:
	pass

func deactivate() -> void:
	pass

func exit() -> void:
	pass

func step() -> void:
	pass

func push(p_new_state: StateNode) -> void:
	push_state.emit(p_new_state)

func pop() -> void:
	pop_state.emit()
