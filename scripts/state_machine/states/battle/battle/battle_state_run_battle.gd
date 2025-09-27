extends BattleStateNode
class_name BattleStateRunBattle



func step() -> void:
	if context.has_team_lost(Team.PLAYER):
		## TODO: Push defeat state
		pass
	if context.has_team_lost(Team.ENEMY):
		## TODO: Push victory state
		pass
	## TODO: Other triggers that may end the match early
	
	push(BattleStateRound.new())
