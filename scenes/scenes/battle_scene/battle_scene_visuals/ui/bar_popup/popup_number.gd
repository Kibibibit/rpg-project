extends Control
class_name PopupNumber

const POPUP_NUMBER : PackedScene = preload("uid://do7uvc2bf83wj")

signal done(s_id: int)

@onready var label: Label = %Label

var _tween: Tween
var _initial_position: Vector2
var _index: int = -1
var _number: String = ""

static func new_popup_number(p_initial_position: Vector2, p_number: int) -> PopupNumber:
	var out: PopupNumber = POPUP_NUMBER.instantiate() as PopupNumber
	out._initial_position = p_initial_position
	out._number = "%d" % p_number
	return out

func _ready() -> void:
	label.text = _number
	global_position = _initial_position-Vector2(0,_index*32)

func move_up() -> void:
	_index += 1
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "global_position", _initial_position-Vector2(0,_index*32), 0.2)
	_tween.tween_interval(1.0)
	_tween.tween_property(self, "modulate", Color(1.0,1.0,1.0, 0.0), 0.4)
	_tween.tween_callback(_on_done)
	_tween.play()

func _on_done() -> void:
	done.emit(get_instance_id())
