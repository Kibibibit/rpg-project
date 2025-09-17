extends Control
class_name TurnOrderPortrait

const _PACKED_SCENE : PackedScene = preload("res://scenes/scenes/battle_scene/battle_scene_visuals/ui/turn_order_visualiser/turn_order_portrait/turn_order_portrait.tscn")

const WIDTH: int = 64 + 8
const HEIGHT: int = 128


static func new_portrait(p_character: Character) -> TurnOrderPortrait:
	var out: TurnOrderPortrait = _PACKED_SCENE.instantiate()
	out.character = p_character
	return out

@onready
var portrait_rect: TextureRect = %PortraitRect
@onready
var name_label: Label = %NameLabel

var target_visible: bool = false
var character: Character
var target_position: Vector2 = Vector2(-WIDTH, -HEIGHT)
var _tween: Tween

func _ready() -> void:
	visible = false



func update() -> void:
	name_label.text = character.character_name
	
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "position", target_position, 0.1)
	_tween.tween_callback(_update_target_visible)
	_tween.play()

func _update_target_visible() -> void:
	visible = target_visible
	
