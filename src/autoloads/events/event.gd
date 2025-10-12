@abstract
extends RefCounted
class_name Event

const TYPE_ERROR_NO_TYPE: StringName = &"event/error/no_event_type"

var type: StringName:
	get:
		return get_type()

@abstract
func get_type() -> StringName
