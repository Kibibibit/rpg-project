extends Node2D

var player_party_ready: bool = false
var enemy_party_ready: bool = false

func _ready() -> void:
	_setup_signals()
	
func _setup_signals() -> void:
	SignalBus.Battle.on_party_ready.connect(_on_party_ready)

func _on_party_ready(p_is_player_party: bool) -> void:
	if p_is_player_party:
		player_party_ready = true
	else:
		enemy_party_ready = true
	if player_party_ready and enemy_party_ready:
		await get_tree().create_timer(0.5).timeout # TODO: Timing
		SignalBus.Battle.emit_on_battle_start_complete.call_deferred()
