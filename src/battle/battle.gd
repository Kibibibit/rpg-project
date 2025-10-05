extends Node
class_name Battle

signal battle_finished(player_won: bool)

@export var backdrop_parent: Node3D
@export var actor_director: BattleActorDirector




func add_backdrop(backdrop: PackedScene) -> void:
	backdrop_parent.add_child(backdrop.instantiate())


func start() -> void:
	
	## TODO: initial setup and the like

	do_battle_step()


func do_battle_step() -> void:
	if is_battle_over():
		battle_finished.emit(actor_director.all_enemies_defeated())
		return
	
	if actor_director.turn_order.is_empty():
		BattleEvents.new_round.emit() ## TODO Maybe await animation
		actor_director.create_turn_order()
	
	var actor: BattleActor = actor_director.pop_next_actor()
	assert(actor.alive, "Actor in turn order is not alive")

	actor.skill_finished.connect(turn_cleanup.bind(actor), ConnectFlags.ONESHOT)

	actor.trigger_select_skill()
		

func is_battle_over() -> bool:
	return actor_director.all_enemies_defeated() or actor_director.all_players_defeated()


func turn_cleanup(_actor: BattleActor) -> void:
	# TODO: Mabye do something here
	do_battle_step()
