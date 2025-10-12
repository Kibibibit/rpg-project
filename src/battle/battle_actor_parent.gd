extends Node3D
class_name BattleActorParent

@onready var player_parent: Marker3D = %PlayerParent
@onready var enemy_parent: Marker3D = %EnemyParent


func _clear_grandchildren(child: Node) -> void:
	for grandchild in child.get_children():
		grandchild.queue_free()
		
func add_player_actors(characters: Array[Character]) -> void:
	_add_battle_actors(characters, Team.PLAYER)

func add_enemy_actors(characters: Array[Character]) -> void:
	_add_battle_actors(characters, Team.ENEMY)

func _add_battle_actors(characters: Array[Character], team: Team.Type) -> void:
	var parent: Node3D
	if team == Team.PLAYER:
		parent = player_parent
	elif team == Team.ENEMY:
		parent = enemy_parent
	else:
		push_error("Tried to add actors to invalid team %s" % str(team))
	
	var x_offset: float = (float(len(characters) - 1) / 2.0) * -2.0 ## TODO: Proper placement
	for character in characters:
		var battle_actor := BattleActor.from_character(character, team)
		if battle_actor == null:
			push_error("Failed to create BattleActor for character: %s" % str(character))
			continue
		battle_actor.position = Vector3(x_offset, 0, 0)
		battle_actor.name = "BattleActor_%s_%d" % [str(character.def.char_name), parent.get_child_count()]
		parent.add_child(battle_actor)
		x_offset += 2

func clear_actors() -> void:
	_clear_grandchildren(player_parent)
	_clear_grandchildren(enemy_parent)
