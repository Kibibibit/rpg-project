extends Control
class_name Select

const CLOSED: int = -1

@export var item_list: ItemList

signal option_selected(option_id: int)

var selected_index: int = -1
var options: Array[SelectOption] = []
var closeable: bool = true


static func create(
	p_options: Array[SelectOption],
) -> Select:
	var scene := UIDLookup.load_packed_scene(&"prefab/ui/select")
	var instance := scene.instantiate() as Select
	instance.clear_options()
	for option in p_options:
		instance.add_option(option)
	return instance

static func popup(
	parent: Control,
	p_options: Array[SelectOption],
	p_closeable: bool = true,
	anchor_preset: LayoutPreset = LayoutPreset.PRESET_TOP_LEFT
) -> int:
	var select := Select.create(p_options)
	select.set_anchors_preset(anchor_preset)
	select.closeable = p_closeable
	parent.add_child(select)
	
	select.item_list.reset_size()
	select.item_list.set_anchors_preset(anchor_preset)
	
	await select.option_selected
	select.queue_free()
	return select.selected_index




func _ready() -> void:
	item_list.item_selected.connect(_on_item_selected)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and closeable:
		selected_index = CLOSED
		option_selected.emit(selected_index)
		get_viewport().set_input_as_handled()

func add_option(option: SelectOption) -> void:
	var index: int = item_list.get_item_count()
	options.append(option)
	item_list.add_item(option.text, option.icon, option.selectable)
	if option.disabled:
		item_list.set_item_disabled(index, true)
	else:
		item_list.set_item_disabled(index, false)
	
func clear_options() -> void:
	options.clear()
	item_list.clear()


func _on_item_selected(index: int) -> void:
	if index < 0 or index >= options.size():
		push_error("Option index out:%d out of bounds for list with len: %d" % [index, options.size()])
		return
	selected_index = index
	option_selected.emit(index)	
