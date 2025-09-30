extends Control
class_name TargetCursorParent

var cursors: Dictionary[int, TargetCursor] = {}

func _ready() -> void:
	visible = false
	SignalBus.Battle.show_target_menu.connect(_show_target_menu)
	SignalBus.Battle.hide_target_menu.connect(_hide_target_menu)
	SignalBus.Battle.target_characters.connect(_target_character)

func _show_target_menu() -> void:
	visible = true

func _hide_target_menu() -> void:
	visible = false
	cursors.clear()
	while get_child_count() > 0:
		var child := get_child(0)
		remove_child(child)
		child.queue_free()

func _target_character(p_character_ids: Array[int]) -> void:
	var unused_cursors: Array[TargetCursor] = []
	for character_id in cursors.keys():
		if not character_id in p_character_ids:
			unused_cursors.append(cursors[character_id])
			cursors.erase(character_id)

	for character_id in p_character_ids:
		var cursor: TargetCursor = null
		if not character_id in cursors:
			if not unused_cursors.is_empty():
				cursor = unused_cursors.pop_back()
			else:
				cursor = TargetCursor.create()
				add_child(cursor)
			cursors[character_id] = cursor

	for cursor in unused_cursors:
		cursor.queue_free()
		remove_child(cursor)
	
	for character_id in cursors.keys():
		cursors[character_id].target_character(character_id)
