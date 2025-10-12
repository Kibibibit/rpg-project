extends Node
class_name BattleAIManager


var _get_valid_skills_callable: Callable
var _get_valid_targets_callable: Callable


var nothing_skill: Skill

func _ready() -> void:
	nothing_skill = UIDLookup.load_skill(&"skill/nothing")
	BattleEventBus.event_fired.connect(_on_event)




func _on_event(event: BattleEvent) -> void:
	if event.type != BattleEvent.TYPE_GET_AI_ACTION:
		return
	if not event is BattleEventGetAIAction:
		push_error("Event type is TYPE_GET_AI_ACTION but event is not BattleEventGetAIAction")
		return
	
	var character: Character = (event as BattleEventGetAIAction).character

	match character.get_ai_mode():
		AIMode.RANDOM:
			_get_random_skill(character)








func _get_random_skill(character: Character) -> void:
	var skills: Array[Skill] = get_valid_skills(character)

	if not get_valid_targets(character, character.unarmed_attack_skill).is_empty():
		skills.append(character.unarmed_attack_skill)

	if skills.is_empty():
		BattleEventBus.push_event(BattleEventSelectedSkill.new(character, nothing_skill, [character]))
		return

	var skill: Skill = skills.pick_random()
	var valid_targets: Array[Character] = get_valid_targets(character, skill)

	if skill.target_scope == Skill.TargetScope.SINGLE:
		valid_targets = [valid_targets.pick_random()]

	BattleEventBus.push_event(BattleEventSelectedSkill.new(character, skill, valid_targets))




func get_valid_skills(character: Character) -> Array[Skill]:
	return _get_valid_skills_callable.call(character)

func get_valid_targets(character: Character, skill: Skill) -> Array[Character]:
	return _get_valid_targets_callable.call(character, skill)
