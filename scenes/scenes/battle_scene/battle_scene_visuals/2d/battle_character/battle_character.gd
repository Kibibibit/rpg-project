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

var hp_bar: BarPopup
var character: Character
var _tween: Tween
var target_position: Vector2


func _ready() -> void:
	if character:
		name_label.text = character.character_name
	_setup_signals()

func _setup_signals() -> void:
	SignalBus.Battle.UI.show_damage_number.connect(_show_damage_number)

func update() -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_property(self, "position", target_position, 0.5)
	_tween.tween_callback(_on_update_done)
	_tween.play()

func _on_update_done() -> void:
	SignalBus.Battle.UI.emit_on_character_ready(character.get_instance_id())

func _show_damage_number(
	p_character_id: int,
	p_amount: int
) -> void:
	if character.get_instance_id() == p_character_id:
		# TODO: Signal to tell character when bar has died
		if !hp_bar:
			hp_bar = BarPopup.new_popup_bar()
			hp_bar.done.connect(_clear_hp_bar)
			add_child(hp_bar)
		hp_bar.update.call_deferred(character.hp + p_amount, character.hp, character.max_hp)

func _clear_hp_bar() -> void:
	hp_bar = null
