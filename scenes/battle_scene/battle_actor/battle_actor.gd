extends Node3D
class_name BattleActor

const _PACKED_SCENE: PackedScene = preload("uid://c3r2yypdicg0v")

static func from_character_id(p_character_id: int) ->  BattleActor:
	var instance := _PACKED_SCENE.instantiate() as BattleActor
	instance.character_id = p_character_id
	return instance
	
	
@onready var skin_parent: Node3D = %SkinParent
var skin: CharacterSkin

var context: BattleContext
var character_id: int
var skin_transform: Transform3D

func _ready() -> void:
	context = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	context.add_battle_actor(character_id, self)
	skin = skin_parent.get_child(0) as CharacterSkin
	if not skin:
		push_error("No skin found in BattleActor for character id %d" % character_id)
		return
	skin_transform = skin.global_transform

func reset_skin() -> void:
	skin.global_transform = skin_transform

	
func get_center_of_mass_global_position() -> Vector3:
	return skin.center_of_mass.global_position
