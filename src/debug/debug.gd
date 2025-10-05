extends CanvasLayer

@onready var test_battle_button: Button = $Control/GridContainer/TestBattleButton

const TEST_BACKDROP = preload("uid://cgkk16pwss3vn")

func _ready() -> void:
	visible = false
	## TODO: Create battle with specific actors
	test_battle_button.pressed.connect(func():
		GlobalEvents.battle_triggered.emit(TEST_BACKDROP)
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_show_ui"):
		visible = not visible
