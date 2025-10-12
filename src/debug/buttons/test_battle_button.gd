extends TestButton

func _on_pressed() -> void:
	var char_def_a := UIDLookup.load_character_definition(&"chardef/test/a")
	var char_def_b := UIDLookup.load_character_definition(&"chardef/test/b")
	var char_def_c := UIDLookup.load_character_definition(&"chardef/test/c")
	var char_def_d := UIDLookup.load_character_definition(&"chardef/test/d")

	var char_a := Character.from_definition(char_def_a)
	var char_b := Character.from_definition(char_def_b)
	var char_c := Character.from_definition(char_def_c)
	var char_d := Character.from_definition(char_def_d)
	
	var player_characters: Array[Character] = [char_a,char_b]
	var enemy_characters: Array[Character] = [char_c, char_d]
	
	GlobalEvents.battle_triggered.emit(
		player_characters,
		enemy_characters,
		&"backdrop/test"
	)
