extends Node2D
class_name BattleCharacter

const _PACKED_SCENE: PackedScene = preload("uid://dn051ct866wlc")

static func new_battle_character(p_character_id: int) -> BattleCharacter:
	var instance: BattleCharacter = _PACKED_SCENE.instantiate() as BattleCharacter
	instance.character = Character.from_id(p_character_id)
	return instance

@onready 
var skin_parent: Node2D = %SkinParent
@onready
var name_label: Label = %NameLabel

var character: Character
var _tween: Tween
var target_position: Vector2

func _ready() -> void:
	if character:
		name_label.text = character.character_name

func update() -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "position", target_position, 0.5)
	_tween.tween_callback(_on_update_done)
	_tween.play()

func _on_update_done() -> void:
	SignalBus.Battle.emit_on_character_ready(character.get_instance_id())
