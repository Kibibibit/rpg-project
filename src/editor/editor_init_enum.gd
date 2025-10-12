@tool
extends EditorScript
class_name EditorInitEnum

func _run():
	var current_editor :=  EditorInterface.get_script_editor().get_current_editor()
	if current_editor and current_editor.is_class("ScriptTextEditor"):
		var code_edit := current_editor.get_base_editor() as CodeEdit
		var new_lines := _create_new_lines(_get_name())
		code_edit.text = "\n".join(new_lines)

func _get_name() -> String:
	var path: String = EditorInterface.get_script_editor().get_current_script().resource_path
	print(path)
	path = path.split("/")[-1]
	print(path)
	path = path.replace(path.get_extension(),"")
	print(path)
	path = path.replace(".","_")
	print(path)
	return path.to_pascal_case()
	
	

func _create_new_lines(name: String) -> Array[String]:

	var out_lines: Array[String] = [
		"## ENUM FILE",
		"@abstract",
		"extends EnumBase",
		"class_name %s" % name,
		"",
		"",
		"enum Type {",
		"",
		"}",
		"",
		"",
		"const VALUES: Array[Type] = [",
		"]",
		""
	]
				
	return out_lines
