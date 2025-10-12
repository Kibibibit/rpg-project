@abstract
extends Button
class_name TestButton

func _ready() -> void:
	self.pressed.connect(_on_pressed)

func _on_pressed() -> void:
	pass
