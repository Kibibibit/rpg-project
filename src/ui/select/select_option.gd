extends RefCounted
class_name SelectOption


var text: String
var icon: Texture2D
var selectable: bool
var disabled: bool

func _init(
	p_text: String,
	p_icon: Texture2D = null,
	p_selectable: bool = true,
	p_disabled: bool = false
) -> void:
	text = p_text
	icon = p_icon
	selectable = p_selectable
	disabled = p_disabled

func with_icon(p_icon: Texture2D) -> SelectOption:
	icon = p_icon
	return self
func with_disabled(p_disabled: bool) -> SelectOption:
	disabled = p_disabled
	return self
func with_selectable(p_selectable: bool) -> SelectOption:
	selectable = p_selectable
	return self
