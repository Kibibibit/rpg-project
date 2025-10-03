@tool
extends EditorScript
class_name EditorUpdateEnum




func _run():
	
	var current_editor :=  EditorInterface.get_script_editor().get_current_editor()
	if current_editor and current_editor.is_class("ScriptTextEditor"):
		var code_edit := current_editor.get_base_editor() as CodeEdit
		var is_enum := _validate(code_edit.text)
		if is_enum:
			var new_lines := _create_new_lines(code_edit.text)
			code_edit.text = "\n".join(new_lines)

func _validate(p_code: String) -> bool:
	var has_type: bool = "enum Type {" in p_code
	var extends_enum_base: bool = "extends EnumBase" in p_code
	var has_tag: bool = p_code.begins_with("## ENUM FILE")
	if not has_type:
		push_warning("Cannot update enum -> Does not have enum Type")
	if not extends_enum_base:
		push_warning("Cannot update enum -> Does not extend EnumBase")
	if not has_tag:
		push_warning("Cannot update enum -> Does not begin with ## ENUM FILE")
	return  has_type and extends_enum_base and has_tag

func _create_new_lines(p_code: String) -> Array[String]:
	var lines := p_code.split("\n", false)
	var name := ""
	var values: Array[String] = []
	var in_enum: bool = false
	for line in lines:
		if not in_enum:
			if "class_name" in line:
				name = _get_class_name(line)
				continue
			if "enum Type {" in line:
				in_enum = true
				continue
		else:
			if "}" in line:
				in_enum = false
				continue
			values.append(line.strip_edges().replace(",",""))
	
	var out_lines: Array[String] = [
		"## ENUM FILE",
		"@abstract",
		"extends EnumBase",
		"class_name %s" % name,
		"",
		""
	]
	
	var enum_lines: Array[String] = [
		"enum Type {"
	]
	var const_lines: Array[String] = []
	var all_lines: Array[String] = [
		"const VALUES: Array[Type] = ["
	]
	
	var index: int = 0
	for value in values:
		enum_lines.append("\t%s" % value)
		const_lines.append("const %s := Type.%s" % [value, value])
		all_lines.append("\t%s" % value)
		if index < len(values)-1:
			enum_lines[-1] += ","
			all_lines[-1] += ","
		index+=1
	enum_lines.append("}")
	all_lines.append("]")
	out_lines.append_array(enum_lines)
	out_lines.append("")
	out_lines.append_array(const_lines)
	out_lines.append("")
	out_lines.append_array(all_lines)
				
	return out_lines
	
func _get_class_name(p_line: String) -> String:
	var parts := p_line.split(" ")
	var index: int = 1
	for p in parts:
		if p.strip_edges() == "class_name":
			break
		index += 1
	return parts[index].strip_edges()

	
