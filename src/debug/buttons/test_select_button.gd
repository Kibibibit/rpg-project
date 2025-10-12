extends TestButton

var open: bool = false

func _on_pressed() -> void:
	
	if open:
		return
	open = true
	
	var options: Array[SelectOption] = [
		SelectOption.new("Option 0"),
		SelectOption.new("Option 1").with_disabled(true),
		SelectOption.new("Option 2", load("res://resource/icons/item.png")),
		SelectOption.new("Option 3").with_selectable(false)
	]
	
	var option: int = await Select.popup(
		self, options
	)
	
	open = false
	if option == Select.CLOSED:
		print("Closed !")
		return
	
	print(options[option].text)
	
