extends BattleEvent
class_name BattleEventSelectedSkill

var character: Character
var skill: Skill
var targets: Array[Character]


func _init(
	p_character: Character,
	p_skill: Skill,
	p_targets: Array[Character]
) -> void:
	character = p_character
	skill = p_skill
	targets = p_targets


func get_type() -> StringName:
	return BattleEvent.TYPE_SELECTED_SKILL
