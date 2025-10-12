extends Node3D
class_name BattleActor

const _TEAM_GROUPS: Dictionary[Team.Type, StringName] = {
	Team.PLAYER: Groups.PLAYER_ACTORS,
	Team.ENEMY: Groups.ENEMY_ACTORS
}

const _TEAM_ACTOR_MODES: Dictionary[Team.Type, ActorMode.Type] = {
	Team.PLAYER: ActorMode.AI, ## TODO: Change to PLAYER once implemented
	Team.ENEMY: ActorMode.AI
}

static func from_character(p_character: Character, team: Team.Type) -> BattleActor:
	
	var packed_scene = UIDLookup.load_packed_scene(&"prefab/battle/battle-actor")
	if packed_scene == null:
		return null
	var instance = packed_scene.instantiate() as BattleActor
	if instance == null:
		push_error("Failed to instantiate BattleActor from PackedScene")
		return null
	instance.character = p_character
	instance.actor_mode = _TEAM_ACTOR_MODES[team]
	instance.add_to_group(Groups.BATTLE_ACTORS)
	instance.add_to_group(_TEAM_GROUPS[team])
	return instance


@export
var character: Character

@export
var actor_mode: ActorMode.Type

func _ready() -> void:
	if character == null:
		push_error("BattleActor has no character assigned!")
		return
	BattleEventBus.event_fired.connect(_on_battle_event)

	var skin: PackedScene = UIDLookup.load_packed_scene(character.def.skin_id)
	if skin == null:
		return
	var skin_instance := skin.instantiate()
	if skin_instance == null:
		push_error("Failed to instantiate skin for ID: %s" % str(character.def.skin_id))
		return
	add_child(skin_instance)




func _on_battle_event(event: BattleEvent) -> void:
	match event.type:
		BattleEvent.TYPE_GET_CHAR_ACTION:
			_get_char_action(event as BattleEventGetCharAction)
		_:
			return

func _get_char_action(event: BattleEventGetCharAction) -> void:
	if event.character != character:
		return
	
	## TODO: Check for ailments and other things that will affect action selection
	
	if actor_mode == ActorMode.PLAYER:
		BattleEventBus.push_event(
			BattleEventGetPlayerAction.new(character)
		)
	else:
		BattleEventBus.push_event(
			BattleEventGetAIAction.new(character)
		)
