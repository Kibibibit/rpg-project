extends Node2D
class_name BattleCharacter

const _PACKED_SCENE: PackedScene = preload("res://scenes/prefabs/battle_character/battle_character.tscn")

static func new_battle_character(p_character_id: int) -> BattleCharacter:
	var instance: BattleCharacter = _PACKED_SCENE.instantiate() as BattleCharacter
	instance.character = Character.from_id(p_character_id)
	return instance


var character: Character

@onready 
var skin_parent: Node2D = %SkinParent



func get_initiative() -> int:
	return character.get_initiative()

func can_cast(_p_skill: Skill) -> bool:
	# TODO: implement
	return true
