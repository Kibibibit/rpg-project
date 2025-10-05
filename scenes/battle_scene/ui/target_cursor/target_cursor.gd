extends Control
class_name TargetCursor

const _PACKED_SCENE := preload("uid://bsnuqk4t0nm4k")

static func create() -> TargetCursor:
	var instance := _PACKED_SCENE.instantiate() as TargetCursor
	return instance

var target: int = -1

func get_char_position(p_character_id: int) -> Vector2:
	var battle_context: BattleContext = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	var viewport: Viewport = get_viewport()
	var battle_actor: BattleActor = battle_context.battle_actors[p_character_id]
	var pos := battle_actor.get_center_of_mass_global_position()
	return viewport.get_camera_3d().unproject_position(pos)

func target_character(p_character_id: int) -> void:
	target = p_character_id
	self.position = get_char_position(target)
	

func _process(_delta: float) -> void:
	if target == -1:
		return
	self.position = get_char_position(target)
