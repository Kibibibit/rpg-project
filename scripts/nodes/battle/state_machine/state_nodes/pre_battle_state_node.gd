extends BattleStateNode
class_name PreBattleStateNode

@export
var round_start_state: BattleStateNode

var awaiting_characters: Array[int] = []


func state_enter(p_battle_state: BattleStateData) -> void:
	for character in p_battle_state.player_characters.values():
		_create_battle_character(character, Team.PLAYER)
	for character in p_battle_state.enemy_characters.values():
		_create_battle_character(character, Team.ENEMY)
	


func update_state(_p_battle_state: BattleStateData, p_event: BattleStateEvent) -> BattleStateNode:
	if p_event.get_type() == BattleStateEvent.Type.PRE_BATTLE_ANIMATION_COMPLETE:
		return round_start_state
	return null


func _create_battle_character(p_character: Character, p_team: Team.Type) -> void:
	var battle_character := BattleCharacter.new_battle_character(p_character)
	awaiting_characters.append(battle_character.get_instance_id())
	SignalBus.Battle.emit_add_battle_character(battle_character, p_team)
