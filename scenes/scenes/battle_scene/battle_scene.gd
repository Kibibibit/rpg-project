extends Node



func _ready() -> void:
	var battle_runner: BattleRunner = $BattleRunner
	
	var char_def_player_a: CharacterDef = load("res://resource/character_defs/char_def_hero_a.tres")
	var char_def_player_b: CharacterDef = load("res://resource/character_defs/char_def_hero_b.tres")
	var char_def_player_c: CharacterDef = load("res://resource/character_defs/char_def_hero_c.tres")
	var char_def_player_d: CharacterDef = load("res://resource/character_defs/char_def_hero_d.tres")
	
	var char_def_enemy_a: CharacterDef = load("res://resource/character_defs/char_def_enemy_a.tres")
	
	battle_runner.run_battle(
		[
			Character.new(char_def_player_a),
			Character.new(char_def_player_b),
			Character.new(char_def_player_c),
			Character.new(char_def_player_d),
		],
		[
			Character.new(char_def_enemy_a),
			Character.new(char_def_enemy_a),
			Character.new(char_def_enemy_a),
			Character.new(char_def_enemy_a)
		]
	)
