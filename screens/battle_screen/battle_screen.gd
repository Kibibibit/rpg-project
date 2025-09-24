extends Node

@onready
var battle_manager: BattleManagerNode = $BattleManagerNode

func _ready() -> void:
	battle_manager.start_battle([], [])
