extends BattleStateNode
class_name BattleStateRunBattle


func enter() -> void:
	for character in context.character_map.values():
		SignalBus.Battle.spawn_actor.emit(character.id, context.get_character_team(character))
	

func step() -> void:
	if context.has_team_lost(Team.PLAYER):
		## TODO: Push defeat state
		pass
	if context.has_team_lost(Team.ENEMY):
		## TODO: Push victory state
		pass
	## TODO: Other triggers that may end the battle early
	
	push(BattleStateRound.new())
