@abstract
extends Control
class_name ControlStateNode




signal push_state(s_new_state: ControlStateNode)
signal pop_state()
signal pop_state_until(p_name: String)

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

func push(p_new_state: ControlStateNode) -> void:
	push_state.emit(p_new_state)

func pop() -> void:
	pop_state.emit()

func pop_until(p_name: ControlStateNode) -> void:
	pop_state_until.emit(p_name)
