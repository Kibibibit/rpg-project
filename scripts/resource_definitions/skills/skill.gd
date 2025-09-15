extends Resource
class_name Skill

@export
var skill_name: String
@export
var effects: Array[SkillEffect] = []

@export_group("Cost")
@export
var cost: int = 0
@export
var cost_type: ResourceCost.Type = ResourceCost.MP
@export
var percentage_cost: bool = false
@export
var allowed_to_kill: bool = false

@export_group("Targeting")

@export_flags("Self", "Allies", "Enemies")
var target_group: int = TargetGroup.NONE


enum TargetType {
	SINGLE,
	ALL,
	RANDOM
}

@export
var target_type: TargetType = TargetType.SINGLE

@export
var min_random_targets: int = 1
@export
var max_random_targets: int = 1



static func from_id(p_skill_id: int) -> Skill:
	return instance_from_id(p_skill_id)

static func get_valid_targets(p_skill: Skill, p_caster_id: int, p_caster_party_ids: Array[int], p_enemy_party_ids: Array[int]) -> Array[int]:
	var valid_targets: Array[int] = []
	var allied_party: Array[int] = p_caster_party_ids.filter(func(p_id: int): return p_id != p_caster_id)
	
	if p_skill.target_group & TargetGroup.SELF != 0:
		valid_targets.append(p_caster_id)
	if p_skill.target_group & TargetGroup.ALLIES != 0:
		valid_targets.append_array(allied_party)
	if p_skill.target_group & TargetGroup.ENEMIES != 0:
		valid_targets.append_array(p_enemy_party_ids)
	return valid_targets
