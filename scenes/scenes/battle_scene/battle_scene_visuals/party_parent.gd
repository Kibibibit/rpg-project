extends Node3D
class_name PartyParent

@export
var team: Team.Type

var battle_characters: Dictionary[int, BattleCharacter] = {}

func _ready() -> void:
	_setup_signals()


func _setup_signals() -> void:
	SignalBus.Battle.add_battle_character.connect(_add_battle_character)



func _add_battle_character(p_battle_character: BattleCharacter, p_team: Team.Type) -> void:
	if p_team != team:
		return
	battle_characters[p_battle_character.get_instance_id()] = p_battle_character
	p_battle_character.position.x = 4.0 - len(battle_characters)*2.0
	p_battle_character.visible = false
	add_child(p_battle_character)
	p_battle_character.enter_scene()
