extends BattleStateNode
class_name BattleStatePlayerAction

var selected_skill_id: int = -1
var character_id: int
var round_number: int

func enter() -> void:
	character_id = context.get_current_character_id()
	round_number = context.round_number
	selected_skill_id = -1

func activate() -> void:
	if context.get_current_character_id() != character_id or context.round_number != round_number:
		pop()
		return
	SignalBus.Battle.show_action_menu.emit()
	SignalBus.Battle.skill_selected.connect(_on_skill_selected)



func deactivate() -> void:
	SignalBus.Battle.hide_action_menu.emit()
	SignalBus.Battle.skill_selected.disconnect(_on_skill_selected)

func _on_skill_selected(s_skill_id: int) -> void:
	selected_skill_id = s_skill_id
	if selected_skill_id != -1:
		var skill_state := BattleStateUseSkill.new()
		skill_state.skill_id = selected_skill_id
		push(skill_state)
