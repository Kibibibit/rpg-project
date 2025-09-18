extends Node2D
class_name VFXManager

const EXAMPLE_VFX := preload("uid://ddtf1dvkm5rx8")

var running_animations: Dictionary[int, VFXInstance] = {}
var damage_effects: Dictionary[int, SkillEffectResultDamage] = {}

var _get_battle_character_callback: Callable

func _ready() -> void:
	_setup_signals()

func _setup_signals() -> void:
	SignalBus.Battle.do_skill_animation.connect(_on_request_skill_animation)

func set_get_battle_character(p_callback: Callable) -> void:
	_get_battle_character_callback = p_callback

func get_battle_character(p_character_id: int) -> BattleCharacter:
	return _get_battle_character_callback.call(p_character_id)

func _on_request_skill_animation(
	p_result: SkillResult
) -> void:

	for effect in p_result.effect_results:
		if effect.get_type() == SkillEffectResult.Type.DAMAGE:
			var vfx_instance: VFXInstance = EXAMPLE_VFX.instantiate() as VFXInstance
			effect = effect as SkillEffectResultDamage
			vfx_instance.global_position = get_battle_character(effect.caster.get_instance_id()).global_position
			vfx_instance.target_position = get_battle_character(effect.target.get_instance_id()).global_position
			add_child(vfx_instance)
			damage_effects[vfx_instance.get_instance_id()] = effect
			vfx_instance.on_complete.connect(_on_vfx_complete)
			running_animations[vfx_instance.get_instance_id()] = vfx_instance
			vfx_instance.start.call_deferred()
		await get_tree().create_timer(0.1).timeout
		
		
func _on_vfx_complete(p_vfx_id: int) -> void:
	if p_vfx_id in running_animations:
		var instance : VFXInstance = running_animations[p_vfx_id]
		instance.queue_free()
		instance.on_complete.disconnect(_on_vfx_complete)
		remove_child(instance)
		running_animations.erase(p_vfx_id)
		var effect := damage_effects[p_vfx_id]
		damage_effects.erase(p_vfx_id)
		
		SignalBus.Battle.UI.emit_show_damage_number(
			effect.target.get_instance_id(),
			effect.amount,
		)


	if running_animations.size() == 0:
		SignalBus.Battle.emit_skill_animation_complete()
