extends Node
class_name AIController

const _BASIC_ATTACK: Skill = preload("res://resource/skills/basic_attacks/skill_basic_attack_bash.tres")

func _ready() -> void:
	_setup_signals()
	

func _setup_signals() -> void:
	SignalBus.Battle.request_ai_skill.connect(_on_request_ai_skill)


func _on_request_ai_skill(p_character: Character, p_battle_state: BattleState, p_is_player: bool) -> void:
	## TODO: Proper implementation
	
	var possible_skills: Array[Skill] = p_character.get_skills().filter(func(s: Skill): return p_character.can_cast_skill(s))
	var ally_party: Array[int] = []
	var enemy_party: Array[int] = []
	if p_is_player:
		ally_party = p_battle_state.get_player_character_ids()
		enemy_party = p_battle_state.get_enemy_character_ids()
	else:
		ally_party = p_battle_state.get_enemy_character_ids()
		enemy_party = p_battle_state.get_player_character_ids()
	
	var chosen_skill: Skill = null
	if (possible_skills.is_empty()):
		if (p_character.def.basic_attack == null):
			chosen_skill = _BASIC_ATTACK
		else:
			chosen_skill = p_character.def.basic_attack
	else:
		chosen_skill = possible_skills.pick_random()
	
	var targets: Array[int] = Skill.get_valid_targets(chosen_skill, p_character.get_instance_id(), ally_party, enemy_party)
	
	if chosen_skill.target_type == Skill.TargetType.SINGLE:
		targets = [targets.pick_random()]
	
	SignalBus.Battle.emit_skill_selected.call_deferred(chosen_skill, targets)
	
	
