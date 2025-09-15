extends Resource
class_name Character

var def: CharacterDef


var mp: int = 100 # TODO: Define properly
var hp: int = 100 # TODO: Define properly

var skills: Array[Skill] = []

var stats: Stats

static func from_id(p_id: int) -> Character:
	return instance_from_id(p_id) as Character

func _init(character_def: CharacterDef) -> void:
	def = character_def
	skills = character_def.base_skills.duplicate()
	stats = character_def.stats.duplicate()


func get_element_affinity(p_element: Element.Type) -> Affinity.Type:
	# TODO: allow this to be overwritten
	return def.get_element_affinity(p_element)




func get_initiative() -> int:
	return stats.agility ## TODO: Apply modifiers

func clear_battle_state() -> void:
	# TODO: Clear temporary battle state like buffs/debuffs
	pass

func get_percentage_cost(p_resource:int, p_percentage: int) -> int:
	return floori(float(p_resource * p_percentage) * 0.001)

func can_cast_skill(p_skill: Skill) -> bool:
	var uses_mp: bool = p_skill.cost_type == ResourceCost.MP
	var required_cost: int = p_skill.cost
	var total: int = mp if uses_mp else hp
	if p_skill.percentage_cost:
		required_cost = get_percentage_cost(total, required_cost)
	
	if uses_mp or p_skill.allowed_to_kill:
		return required_cost <= total
	else:
		return required_cost < total

func get_resource_total(p_resource: ResourceCost.Type) -> int:
	if p_resource == ResourceCost.MP:
		return mp
	else:
		return hp

func apply_cost(p_skill: Skill) -> int:
	var cost: int = p_skill.cost
	var uses_mp: bool = p_skill.cost_type == ResourceCost.MP
	var total: int = mp if uses_mp else hp
	if p_skill.percentage_cost:
		cost = get_percentage_cost(total, cost)
	
	if uses_mp:
		mp -= cost
	else:
		hp -= cost
	return cost


func deal_damage(p_amount: int) -> void:
	hp = maxi(hp-p_amount, 0)

func heal(p_amount: int) -> void:
	hp = mini(hp+p_amount, 100) # TODO: Max hp

func get_skills() -> Array[Skill]:
	# TODO: Account for new skills from levels, equipment, story
	return skills


func get_strength_damage_multiplier() -> float:
	return float(stats.strength) * 0.01

func get_magic_damage_multiplier() -> float:
	return float(stats.magic) * 0.01

func get_defense_damage_multiplier() -> float:
	return float(stats.endurance) * 0.01

func get_crit_chance_multiplier() -> float:
	return float(stats.luck) * 0.005

func get_crit_avoid_multiplier() -> float:
	return float(stats.luck) * 0.0075
