extends Node
class_name EffectRunner

@onready var scene_3d: BattleScene3D = %"3D"
var context: BattleContext

func _ready() -> void:
	context = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	SignalBus.Battle.display_skill_result.connect(_display_skill_result)


func _display_skill_result(p_result: SkillResult) -> void:
	
	var spell_results: Array[SkillEffectResult] = p_result.get_phase_one_effects()
	
	var damage_results: Array[SkillEffectResultDamage] = []
	for res in spell_results:
		if res.get_type() == SkillEffectResult.Type.DAMAGE:
			damage_results.append(res)
	
	await _display_spell_effects(damage_results, p_result.skill)
	
	SignalBus.Battle.skill_result_finished.emit()

func _display_spell_effects(p_damage_results: Array[SkillEffectResultDamage], p_skill: Skill) -> void:
	## TODO: Do something with hit frame reached. Maybe make it a signal bus thing
	var effect_nodes: Array[SpellEffectNode] = []
	var effect_node_signals: Array[Signal] = []
	for result in p_damage_results:
		var effect_node: SpellEffectNode = p_skill.get_spell_effect()
		## TODO: Dynamic delay based on skill
		effect_node.delay = 0.1 + len(effect_nodes) * 0.5
		effect_node_signals.append(effect_node.complete)
		effect_nodes.append(effect_node)
		scene_3d.effect_parent.add_child(effect_node)
		effect_node.hit_frame_reached.connect(_on_hit_frame)
		
		var target := context.battle_actors[result.target_id]
		var caster := context.battle_actors[result.caster_id]
		
		
		
		effect_node.play(
			caster.get_center_of_mass_global_position(),
			target.get_center_of_mass_global_position(),
			result
		)
	await SignalGroup.all(effect_node_signals)
	
	while scene_3d.effect_parent.get_child_count() > 0:
		var c := scene_3d.effect_parent.get_child(0)
		scene_3d.effect_parent.remove_child(c)
		c.queue_free()

func _on_hit_frame(p_result: SkillEffectResult) -> void:
	if p_result.get_type() == SkillEffectResult.Type.DAMAGE:
		p_result = p_result as SkillEffectResultDamage
		SignalBus.Battle.deal_hit.emit(p_result.target_id, p_result.hits[0].damage)
