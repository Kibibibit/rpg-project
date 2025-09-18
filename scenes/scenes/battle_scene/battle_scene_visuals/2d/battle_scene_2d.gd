extends Node2D

var player_party_ready: bool = false
var enemy_party_ready: bool = false

@onready
var player_party: PartyParent = %PlayerParty
@onready
var enemy_party: PartyParent = %EnemyParty
@onready
var vfx_manager: VFXManager = %VFXManager


func _ready() -> void:
	vfx_manager.set_get_battle_character(get_battle_character)
	_setup_signals()
	
func _setup_signals() -> void:
	SignalBus.Battle.UI.on_party_ready.connect(_on_party_ready)

func get_battle_character(p_character_id: int) -> BattleCharacter:
	# TODO: Refactor
	if p_character_id in player_party.battle_characters.keys():
		return player_party.battle_characters[p_character_id]
	elif p_character_id in enemy_party.battle_characters.keys():
		return enemy_party.battle_characters[p_character_id]
	return null
		

func _on_party_ready(p_is_player_party: bool) -> void:
	if p_is_player_party:
		player_party_ready = true
	else:
		enemy_party_ready = true
	if player_party_ready and enemy_party_ready:
		await get_tree().create_timer(0.5).timeout # TODO: Timing
		SignalBus.Battle.emit_on_battle_start_complete.call_deferred()
