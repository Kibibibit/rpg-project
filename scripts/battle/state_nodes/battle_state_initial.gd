extends BattleStateNode
class_name BattleStateInitial

## Runs any initial setup needed for the battle,
## moving characters into the state data, and so on

var player_characters: Array[CharacterState] = []
var enemy_characters: Array[CharacterState] = []

@export
var round_started_state: BattleStateNode

func get_type() -> Type:
	return Type.INITIAL

func enter_state() -> void:
	_setup_character_maps()
	battle_state_data.round_number = 0

func run_state() -> BattleStateNode:
	return round_started_state

func _setup_character_maps() -> void:
	for character in player_characters:
		battle_state_data.character_map[character.id] = character
		battle_state_data.character_team_map[character.id] = Team.PLAYER
	for character in enemy_characters:
		battle_state_data.character_map[character.id] = character
		battle_state_data.character_team_map[character.id] = Team.ENEMY
