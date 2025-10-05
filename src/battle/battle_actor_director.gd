extends Node3D
class_name BattleActorDirector

var player_actors: Array[BattleActor] = []
var enemy_actors: Array[BattleActor] = []

var turn_order: Array[BattleActor] = []



func pop_next_actor() -> BattleActor:
	assert(not turn_order.is_empty(), "Tried to pop next actor while turn order was full")
	return turn_order.pop_front()

func create_turn_order() -> void:
	
	turn_order.clear()
	turn_order.append_array(player_actors)
	turn_order.append_array(enemy_actors)
	turn_order.sort_custom(func(a: BattleActor, b: BattleActor) -> int:
		return a.get_initiative() - b.get_initiative()
	)

func all_enemies_defeated() -> bool:
	for enemy in enemy_actors:
		if enemy.alive:
			return false
	return true

func all_players_defeated() -> bool:
	for player in player_actors:
		if player.alive:
			return false
	return true
