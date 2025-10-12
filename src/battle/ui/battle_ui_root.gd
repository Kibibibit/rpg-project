extends Control


func _ready() -> void:
	BattleEventBus.event_fired.connect(_on_event)




func _on_event(event: BattleEvent) -> void:
	match event.type:
		BattleEvent.TYPE_GET_PLAYER_ACTION:
			_get_player_action(event as BattleEventGetPlayerAction)

func _get_player_action(event: BattleEventGetPlayerAction) -> void:
	
	var options: Array[SelectOption] = [
		SelectOption.new(event.character.def.char_name)
	]
	
	var skill_index: int = await Select.popup(self, options, false, Control.PRESET_CENTER)
	
	print(skill_index)
	
