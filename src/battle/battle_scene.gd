extends Node3D

@onready var backdrop_parent: Node3D = %BackdropParent
@onready var battle_actor_parent: BattleActorParent = %BattleActorParent
@onready var turn_order_manager: TurnOrderManager = %TurnOrderManager
@onready var battle_ai_manager: BattleAIManager = %BattleAIManager

var player_characters: Array[Character] = []
var enemy_characters: Array[Character] = []

var team_map: Dictionary[int, Team.Type] = {}



func _ready() -> void:
	visible = false
	turn_order_manager._get_all_characters_callable = get_all_characters
	battle_ai_manager._get_valid_skills_callable = get_valid_skills
	battle_ai_manager._get_valid_targets_callable = get_valid_targets



	GlobalEvents.battle_triggered.connect(start_battle)
	_clear_grandchildren(backdrop_parent)
	battle_actor_parent.clear_actors()


func start_battle(
	p_player_characters: Array[Character],
	p_enemy_characters: Array[Character],
	backdrop_id: StringName
):
	
	
	if visible:
		push_error("Battle already in progress!")
		return

	await Transition.wipe_in()

	visible = true
	BattleEventBus.activate()
	BattleEventBus.add_block(self)

	var backdrop_scene := UIDLookup.load_packed_scene(backdrop_id)
	if backdrop_scene == null:
		push_error("Failed to load backdrop scene for ID: %s" % str(backdrop_id))
		return
	
	var backdrop_instance := backdrop_scene.instantiate()
	if backdrop_instance == null:
		push_error("Failed to instantiate backdrop scene for ID: %s" % str(backdrop_id))
		return

	backdrop_parent.add_child(backdrop_instance)

	player_characters = p_player_characters
	enemy_characters = p_enemy_characters
	
	for character in player_characters:
		team_map[character.get_instance_id()] = Team.PLAYER
	for character in enemy_characters:
		team_map[character.get_instance_id()] = Team.ENEMY


	battle_actor_parent.add_player_actors(player_characters)
	battle_actor_parent.add_enemy_actors(enemy_characters)
	
	
	await Transition.wipe_out()
	BattleEventBus.push_event(BattleEventDoNextTurn.new())
	BattleEventBus.remove_block(self)


func _clear_grandchildren(child: Node) -> void:
	for grandchild in child.get_children():
		grandchild.queue_free()

func on_battle_finish() -> void:
	visible = false
	BattleEventBus.deactivate()
	BattleEventBus.clear()

	_clear_grandchildren(backdrop_parent)
	battle_actor_parent.clear_actors()


func get_all_characters() -> Array[Character]:
	return player_characters + enemy_characters

func get_character_team(character: Character) -> Team.Type:
	if not team_map.has(character.get_instance_id()):
		push_warning("Character %s not found in team map" % str(character.def.char_name))
		return Team.ENEMY ## TODO: Error handling

	return team_map[character.get_instance_id()]

func get_team_characters(team: Team.Type) -> Array[Character]:
	if team == Team.PLAYER:
		return player_characters
	elif team == Team.ENEMY:
		return enemy_characters
	else:
		push_warning("Unknown team %s" % str(team))
		return []

## TODO: Implement
func get_valid_skills(character: Character) -> Array[Skill]:
	var all_skills: Array[Skill] = character.get_skills()

	var valid_skills: Array[Skill] = []
	for skill in all_skills:
		## TODO: MP Cost, Ailments, Hp already full for healing skills etc. Maybe add a Skill.valid_target function
		if not get_valid_targets(character, skill).is_empty():
			valid_skills.append(skill)

	return valid_skills

func get_valid_targets(caster: Character, skill: Skill) -> Array[Character]:

	if skill.target_scope == Skill.TargetScope.SELF:
		return [caster]

	var valid_targets: Array[Character] = []
	var ally_team: Team.Type = get_character_team(caster)
	var enemy_team: Team.Type = Team.PLAYER if ally_team == Team.ENEMY else Team.ENEMY
	if skill.target_allies:
		valid_targets.append_array(get_team_characters(ally_team))
	if skill.target_enemies:
		valid_targets.append_array(get_team_characters(enemy_team))

	return valid_targets
