extends Control
class_name TargetCursor

const _PACKED_SCENE := preload("uid://bsnuqk4t0nm4k")

static func create() -> TargetCursor:
	var instance := _PACKED_SCENE.instantiate() as TargetCursor
	return instance

var tween: Tween = null
var target: int = -1

func target_character(p_character_id: int) -> void:
	var battle_context: BattleContext = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	var battle_actor: BattleActor = battle_context.battle_actors[p_character_id]
	var viewport: Viewport = get_viewport()
	var screen_position: Vector2 = viewport.get_camera_3d().unproject_position(battle_actor.get_center_of_mass_global_position())
	if target != -1:
		if tween:
			tween.kill()
		tween = create_tween()
		tween.tween_property(self, "position", screen_position, 0.1)
		tween.play()
	else:
		position = screen_position
	target = p_character_id
