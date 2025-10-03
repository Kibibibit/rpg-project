extends Node3D
class_name SpellEffectNode

signal hit_frame_reached(s_result: SkillEffectResult)
signal complete

@export
var animation_player: AnimationPlayer
@export
var animation: StringName
@export
var hit_frames: int = 1


var delay: float = 0.0
var result: SkillEffectResult

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	visible = false


func play(p_start_position: Vector3, p_end_position: Vector3, p_result: SkillEffectResult) -> void:
	visible = true
	animation_player.play(&"RESET")
	
	self.global_position = p_end_position
	self.look_at(p_start_position)
	self.rotation.x = 0
	self.rotation.z = 0
	result = p_result

	await get_tree().create_timer(delay).timeout
	animation_player.play(animation)
	await animation_player.animation_finished
	visible = false
	complete.emit()

func _emit_hit_frame() -> void:
	hit_frame_reached.emit(result)
