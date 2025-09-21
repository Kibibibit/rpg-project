extends Resource
class_name Character

var def: CharacterDef

var level: int = 1
var character_name: String

var mp: int = 100
var hp: int = 100
var max_hp: int = 0
var max_mp: int = 0

var skills: Array[Skill] = []

var stats: Stats

var modifiers: StatModifiers = StatModifiers.new()


static func from_id(p_id: int) -> Character:
	return instance_from_id(p_id) as Character

func _init(character_def: CharacterDef) -> void:
	def = character_def
	skills = character_def.base_skills.duplicate()
	stats = character_def.stats.duplicate()
	mp = character_def.base_mp
	max_mp = mp
	hp = character_def.base_hp
	max_hp = hp
	level = character_def.base_level
	character_name = character_def.character_name


func get_element_affinity(p_element: Element.Type) -> Affinity.Type:
	# TODO: allow this to be overwritten
	return def.get_element_affinity(p_element)




func get_initiative() -> int:
	return stats.agility ## TODO: Apply modifiers

func clear_battle_state() -> void:
	# TODO: Clear temporary battle state like buffs/debuffs
	modifiers.reset()
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
		mp = maxi(mp-cost, 0)
	else:
		hp = maxi(hp-cost, 0)
	return cost


func deal_damage(p_amount: int) -> void:
	hp = maxi(hp-p_amount, 0)

func heal(p_amount: int) -> void:
	hp = mini(hp+p_amount, max_hp)

func get_skills() -> Array[Skill]:
	# TODO: Account for new skills from levels, equipment, story
	return skills


func get_strength_damage_multiplier() -> float:
	return 1.0 + float(stats.strength) * 0.01

func get_magic_damage_multiplier() -> float:
	return 1.0 + float(stats.magic) * 0.01

func get_defense_damage_multiplier() -> float:
	return 1.0 - float(stats.endurance) * 0.01

func get_crit_chance_multiplier() -> float:
	return 1.0 + float(stats.luck) * 0.005

func get_crit_avoid_multiplier() -> float:
	return 1.0 - float(stats.luck) * 0.00075

func get_accuracy_multiplier() -> float:
	return (1.0 + float(stats.agility) * 0.005) * modifiers.get_speed_accuracy_multiplier()

func get_dodge_multiplier() -> float:
	return (1.0 - float(stats.agility) * 0.00075) * modifiers.get_speed_evasion_multiplier()

func get_attack_buff_multiplier() -> float:
	return modifiers.get_attack_multiplier()

func get_defense_buff_multiplier() -> float:
	return modifiers.get_defense_multiplier()
