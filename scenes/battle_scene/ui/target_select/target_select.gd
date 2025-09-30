extends HBoxContainer
class_name TargetSelect

var context: BattleContext
var valid_targets: Array[int] = []
var selected_target: int = 0

@onready var left_button: Button = %LeftButton
@onready var target_button: Button = %TargetButton
@onready var right_button: Button = %RightButton


func _ready() -> void:
	visible = false
	SignalBus.Battle.show_target_menu.connect(_show_target_menu)
	SignalBus.Battle.hide_target_menu.connect(_hide_target_menu)
	left_button.pressed.connect(_on_left)
	right_button.pressed.connect(_on_right)
	target_button.pressed.connect(_on_select)
	
func _show_target_menu() -> void:
	visible = true
	selected_target = 0
	context = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	valid_targets = context.get_valid_targets(
		context.get_current_character(),
		context.current_skill
	)
	if context.current_skill.target_type != Skill.TargetType.SINGLE or len(valid_targets) <= 1:
		left_button.disabled = true
		right_button.disabled = true
		if len(valid_targets) > 1:
			target_button.text = "(Group)"
		else:
			_update_target_button()
	else:
		left_button.disabled = false
		right_button.disabled = false
		_update_target_button()
	_update_cursor()

func _update_cursor() -> void:
	if context.current_skill.target_type != Skill.TargetType.SINGLE:
		SignalBus.Battle.target_characters.emit(valid_targets)
	else:
		var selected: Array[int] = [valid_targets[selected_target]]
		SignalBus.Battle.target_characters.emit(selected)

func _hide_target_menu() -> void:
	visible = false

func _on_left() -> void:
	selected_target = wrapi(selected_target+1, 0, len(valid_targets))
	_update_target_button()
	_update_cursor()

func _on_right() -> void:
	selected_target = wrapi(selected_target-1, 0, len(valid_targets))
	_update_target_button()
	_update_cursor()

func _update_target_button() -> void:
	target_button.text = context.get_character(valid_targets[selected_target]).definition.name

func _on_select() -> void:
	if context.current_skill.target_type != Skill.TargetType.SINGLE:
		SignalBus.Battle.targets_selected.emit(valid_targets)
	else:
		var selected: Array[int] = [valid_targets[selected_target]]
		SignalBus.Battle.targets_selected.emit(selected)
