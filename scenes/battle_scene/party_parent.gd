extends Node3D
class_name PartyParent

@export
var team: Team.Type

var _characters: Dictionary[int, BattleActor] = {}

func _ready() -> void:
	while get_child_count() > 0:
		var child := get_child(0)
		remove_child(child)
		child.queue_free()
	SignalBus.Battle.spawn_actor.connect(_spawn_actor)


func _spawn_actor(p_character_id: int, p_team: Team.Type) -> void:
	if p_team != team:
		return
	var actor := BattleActor.from_character_id(p_character_id)
	_characters[p_character_id] = actor
	
	actor.position.x = 4 - (2*len(_characters))
	add_child(actor)
	SignalBus.Battle.add_damage_display.emit(p_character_id)
