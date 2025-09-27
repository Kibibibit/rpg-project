extends VBoxContainer

var context: BattleContext


@onready var attack_button: Button = $AttackButton
@onready var skill_button: Button = $SkillButton
@onready var item_button: Button = $ItemButton
@onready var defend_button: Button = $DefendButton
@onready var pass_button: Button = $PassButton


func _ready() -> void:
	visible = false
	context = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	SignalBus.Battle.show_action_menu.connect(_on_show_action_menu)
	SignalBus.Battle.hide_action_menu.connect(_on_hide_action_menu)
	_connect_signals()

func _connect_signals() -> void:
	attack_button.pressed.connect(_on_attack_pressed)
	skill_button.pressed.connect(_on_skill_pressed)
	item_button.pressed.connect(_on_item_pressed)
	defend_button.pressed.connect(_on_defend_pressed)
	pass_button.pressed.connect(_on_pass_pressed)

func _on_show_action_menu() -> void:
	visible = true

func _on_hide_action_menu() -> void:
	visible = false

func _on_attack_pressed() -> void:
	## TODO: Generic skill id for attack
	SignalBus.Battle.skill_selected.emit(1)

func _on_skill_pressed() -> void:
	## TODO: New pop up for skill selection
	SignalBus.Battle.skill_selected.emit(2)

func _on_item_pressed() -> void:
	## TODO: New pop up for item selection
	SignalBus.Battle.skill_selected.emit(3)

func _on_defend_pressed() -> void:
	## TODO: Generic skill id for defend
	SignalBus.Battle.skill_selected.emit(4)

func _on_pass_pressed() -> void:
	## TODO: Generic skill id for pass
	SignalBus.Battle.skill_selected.emit(5)


	
	
