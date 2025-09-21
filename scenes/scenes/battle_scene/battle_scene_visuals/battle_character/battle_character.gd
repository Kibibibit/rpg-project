extends Node3D
class_name BattleCharacter

const _PACKED_SCENE := preload("uid://cmrdxxl8j661")

static func new_battle_character(p_character: Character) -> BattleCharacter:
	var instance: BattleCharacter = _PACKED_SCENE.instantiate()
	instance.character = p_character
	return instance

@onready 
var skin_parent: Node3D = %SkinParent

var character: Character


func enter_scene() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", position + Vector3(0,0,-1), 1.0)
	tween.play()
	visible = true
