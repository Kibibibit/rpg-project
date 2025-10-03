extends BattleStateNode
class_name BattleStateSelectSkill


var selected_skill: Skill = null



func activate() -> void:
	selected_skill = null
	context.current_skill = null
	SignalBus.Battle.show_skill_menu.emit()
	SignalBus.Battle.back.connect(_on_back)
	SignalBus.Battle.skill_selected.connect(_on_skill_selected)

func deactivate() -> void:
	SignalBus.Battle.hide_skill_menu.emit()
	if SignalBus.Battle.back.is_connected(_on_back):
		SignalBus.Battle.back.disconnect(_on_back)
	if SignalBus.Battle.skill_selected.is_connected(_on_skill_selected):
		SignalBus.Battle.skill_selected.disconnect(_on_skill_selected)

func step() -> void:
	if not selected_skill:
		return
	else:
		push(BattleStateSelectTarget.new())

func _on_skill_selected(p_skill: Skill) -> void:
	selected_skill = p_skill
	context.current_skill = p_skill

func _on_back() -> void:
	pop()
