extends Node2D



func _ready() -> void:
	var battle_runner: BattleRunner = $BattleRunner
	
	var char_def_player_a: CharacterDef = load("res://resource/character_defs/char_def_hero_a.tres")
	var char_def_player_b: CharacterDef = load("res://resource/character_defs/char_def_hero_b.tres")
	
	
	
	battle_runner.run_battle(
		[Character.new(char_def_player_a)],
		[Character.new(char_def_player_b)]
	)
