extends CanvasLayer


func _ready() -> void:
	visible = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_show_ui"):
		visible = not visible
