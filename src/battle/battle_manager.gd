extends Node

const BATTLE: PackedScene = preload("uid://j50ei4v5eq0w")

var battle: Battle = null

func _ready() -> void:
	GlobalEvents.battle_triggered.connect(start_battle)

func start_battle(backdrop: PackedScene) -> void:
	
	assert(battle == null, "Tried to start a battle while one was already going!")
	
	battle = BATTLE.instantiate() as Battle
	print(battle, " ", BATTLE)
	battle.add_backdrop(backdrop)
	
	add_child(battle)
	
	battle.battle_finished.connect(
		func(player_won: bool):
			print(player_won)
			
			battle.queue_free()
			battle = null
	)
	
	battle.start()
