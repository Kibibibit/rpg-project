extends BattleStateNode
class_name BattleStateSelectTarget




var character_id: int
var round_number: int

func enter() -> void:
	character_id = context.get_current_character_id()
	round_number = context.round_number


func activate() -> void:
	context.current_targets = []
	if context.get_current_character_id() != character_id or context.round_number != round_number:
		pop()
		return
	SignalBus.Battle.show_target_menu.emit()
	SignalBus.Battle.back.connect(_on_back)
	SignalBus.Battle.targets_selected.connect(_target_selected)
	

func step() -> void:
	if not context.current_targets.is_empty():
		push(BattleStateUseSkill.new())
		
	
func deactivate() -> void:
	## TODO: Don't let ui direct access context maybe? Either that or lint rule to prevent ui modifying context
	SignalBus.Battle.hide_target_menu.emit()
	SignalBus.Battle.back.disconnect(_on_back)
	SignalBus.Battle.targets_selected.disconnect(_target_selected)

func _target_selected(p_character_ids: Array[int]) -> void:
	context.current_targets = p_character_ids

func _on_back() -> void:
	pop()
