extends Node2D
class_name PartyParent

@export
var player_party: bool = false

var battle_characters: Dictionary[int, BattleCharacter] = {}
var _characters_ready: Array[int] = []

func _ready() -> void:
	_setup_signals()


func _setup_signals() -> void:
	SignalBus.Battle.do_battle_start.connect(_on_do_battle_start)
	SignalBus.Battle.UI.on_character_ready.connect(_on_character_ready)


func _on_do_battle_start(p_player_party: Array[Character], p_enemy_party: Array[Character]) -> void:
	var party: Array[Character] = p_player_party if player_party else p_enemy_party
	
	var index: int = 0
	for character in party:
		var c_id: int = character.get_instance_id()
		var battle_character := BattleCharacter.new_battle_character(c_id)
		battle_characters[c_id] = battle_character
		battle_character.position.x = 32 + index * 2048
		battle_character.target_position.x = index * 96
		battle_character.position.y = 500 if player_party else -500
		add_child(battle_character)
		battle_character.update.call_deferred() # in case of immediate return
		index += 1
		
func _on_character_ready(p_character_id: int) -> void:
	if p_character_id in battle_characters.keys():
		_characters_ready.append(p_character_id)
		if _characters_ready.size() == battle_characters.size():
			SignalBus.Battle.UI.emit_on_party_ready.call_deferred(player_party)
