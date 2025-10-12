@abstract
extends RefCounted
class_name ArrayFn

static func filter_str(p_array: Array[String], p_cond: Callable) -> Array[String]:
	var out: Array[String] = []
	for item in p_array:
		if p_cond.call(item):
			out.append(item)
	return out

static func map_str(p_array: Array[String], p_fn: Callable) -> Array[String]:
	var out: Array[String] = []
	for item in p_array:
		out.append(p_fn.call(item))
	return out
