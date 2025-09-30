extends VBoxContainer
class_name SkillSelect

var context: BattleContext



func _ready() -> void:
	visible = false
	SignalBus.Battle.show_skill_menu.connect(_on_show_skill_menu)
	SignalBus.Battle.hide_skill_menu.connect(_on_hide_skill_menu)
	_clear_children()


func _clear_children() -> void:
	while get_child_count() != 0:
		var child: Button = get_child(0)
		if child.pressed.is_connected(_on_button_pressed):
			child.pressed.disconnect(_on_button_pressed)
		remove_child(child)
		child.queue_free()

func _on_show_skill_menu() -> void:
	context = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	visible = true
	var current_character: Character = context.get_current_character()
	var skills := current_character.get_skills()
	for skill in skills:
		var button := Button.new()
		button.custom_minimum_size.x = 250
		button.text = skill.name
		button.pressed.connect(_on_button_pressed.bind(skill))
		var valid_targets := context.get_valid_targets(context.get_current_character(), skill)
		if valid_targets.is_empty():
			button.disabled = true
		add_child(button)

func _on_hide_skill_menu() -> void:
	_clear_children()
	visible = false

func _on_button_pressed(p_skill: Skill) -> void:
	SignalBus.Battle.skill_selected.emit(p_skill)
