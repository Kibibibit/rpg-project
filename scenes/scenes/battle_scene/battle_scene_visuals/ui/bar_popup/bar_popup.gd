extends Control
class_name BarPopup

@onready
var progress_bar: ProgressBar = %ProgressBar
@onready
var label_parent: Control = %LabelParent

signal done

const PACKED_SCENE := preload("uid://x1ksn2uqixhx")

static func new_popup_bar(
) -> BarPopup:
	var instance: BarPopup = PACKED_SCENE.instantiate() as BarPopup
	return instance

var _numbers: Dictionary[int, PopupNumber] = {}

var _tween: Tween

func update(p_from: float, p_to: float, p_total: float) -> void:
	var from_value: float = p_from/p_total
	var to_value: float = p_to/p_total
	if not is_equal_approx(from_value, progress_bar.value):
		progress_bar.value = from_value
	
	if _tween:
		_tween.kill()
	_tween = create_tween()
	
	_tween.tween_property(progress_bar, "value", to_value, 0.1)
	_tween.play()
	
	var popup_number := PopupNumber.new_popup_number(global_position, absi(floori(p_from-p_to)))
	popup_number.done.connect(_on_popup_done)
	_numbers[popup_number.get_instance_id()] = popup_number
	label_parent.add_child(popup_number)
	
	for number in _numbers.values():
		(number as PopupNumber).move_up()

func _on_popup_done(p_id: int) -> void:
	if _numbers.has(p_id):
		var p : PopupNumber = _numbers[p_id]
		p.done.disconnect(_on_popup_done)
		label_parent.remove_child(p)
		p.queue_free()
		_numbers.erase(p_id)
		
	if _numbers.is_empty():
		done.emit()
		get_parent().remove_child(self)
		queue_free()
		
