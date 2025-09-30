extends Control



func _input(event: InputEvent) -> void:
	## TODO: Handle this better. Make an actual action and assign it somewhere
	if event.is_action_pressed("ui_cancel"):
		SignalBus.Battle.back.emit()
