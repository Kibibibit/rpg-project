extends RefCounted
class_name BattleStateData

var round_number: int = 0

var player_characters: Dictionary[int, Character] = {}
var enemy_characters: Dictionary[int, Character] = {}
var character_is_player_map: Dictionary[int, bool] = {}


func _init(p_player_characters: Array[Character], p_enemy_characters: Array[Character]) -> void:
	for c in p_player_characters:
		var c_id: int = c.get_instance_id()
		player_characters[c_id] = c
		character_is_player_map[c_id] =  true
	for c in p_enemy_characters:
		var c_id: int = c.get_instance_id()
		enemy_characters[c_id] = c
		character_is_player_map[c_id] = false
