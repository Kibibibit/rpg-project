extends BattleStateNode
class_name BattleStatePlayerAction

var character_id: int
var selected_action: Action.Type = Action.NONE

func enter() -> void:
	character_id = context.get_current_character_id()

func activate() -> void:
	selected_action = Action.NONE
	context.current_targets = []
	context.current_skill = null
	SignalBus.Battle.show_action_menu.emit()
	SignalBus.Battle.action_selected.connect(_on_action_selected)

func deactivate() -> void:
	SignalBus.Battle.hide_action_menu.emit()
	if SignalBus.Battle.action_selected.is_connected(_on_action_selected):
		SignalBus.Battle.action_selected.disconnect(_on_action_selected)

func _on_action_selected(p_action: Action.Type) -> void:
	selected_action = p_action

func step() -> void:
	if selected_action == Action.NONE:
		return
	match selected_action:
		Action.ATTACK:
			# TODO: Loader for skills
			# TODO: Confirmation state for defend/pass?
			context.current_skill = preload("res://resource/skill/basic/skill_attack.tres")
			push( BattleStateSelectTarget.new())
		Action.DEFEND:
			context.current_skill =  preload("res://resource/skill/basic/skill_defend.tres")
			context.current_targets = [character_id]
			push(BattleStateUseSkill.new())
		Action.PASS:
			context.current_targets = [character_id]
			context.current_skill = preload("res://resource/skill/basic/skill_pass.tres")
			push(BattleStateUseSkill.new())
		Action.ITEM:
			## TODO: Item selection state
			pass
		Action.SKILL:
			push(BattleStateSelectSkill.new())
			pass
		_:
			push_error("Unhandled action selected in BattleStatePlayerAction")
			pop()
