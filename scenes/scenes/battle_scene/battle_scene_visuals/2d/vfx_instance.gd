extends Node2D
class_name VFXInstance


signal on_complete(s_vfx_id: int)

var target_position: Vector2


func start() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "global_position", target_position, 1.0)
	tween.tween_callback(_on_complete)
	tween.play()

func _on_complete() -> void:
	on_complete.emit(get_instance_id())
