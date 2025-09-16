extends Control


var character_id_to_portrait: Dictionary[int, TurnOrderPortrait] = {}
var portrait_id_to_character: Dictionary[int, Character] = {}
var unused_portraits: Array[TurnOrderPortrait] = []

func _ready() -> void:
	_setup_signals()
	
	for child in get_children():
		if child is TurnOrderPortrait:
			unused_portraits.append(child)
		

func _setup_signals() -> void:
	SignalBus.Battle.turn_order_changed.connect(_on_turn_order_changed)


func _on_turn_order_changed(
	p_character_ids: Array[int], 
	_p_is_player_map: Dictionary[int, bool]
) -> void:
	var updated_portraits: Dictionary[int, TurnOrderPortrait] = {}
	
	for character_id in character_id_to_portrait.keys():
		if not character_id in p_character_ids:
			var portrait: TurnOrderPortrait = character_id_to_portrait[character_id]
			portrait.target_position.y = -TurnOrderPortrait.HEIGHT
			portrait.target_visible = false
			updated_portraits[portrait.get_instance_id()] = portrait
			unused_portraits.append(portrait)
			character_id_to_portrait.erase(character_id)
			portrait_id_to_character.erase(portrait.get_instance_id())
	
	var index: int = 0
	for character_id in p_character_ids:
		var portrait: TurnOrderPortrait
		if character_id_to_portrait.has(character_id):
			portrait = character_id_to_portrait[character_id]
		elif not unused_portraits.is_empty():
			portrait = unused_portraits.pop_back()
			portrait.character = Character.from_id(character_id)
			if portrait.position.y < 0:
				portrait.position.x = 8 + index*TurnOrderPortrait.WIDTH
		else:
			portrait = TurnOrderPortrait.new_portrait(Character.from_id(character_id))
			portrait.position.x = 8 + index*TurnOrderPortrait.WIDTH
		
		character_id_to_portrait[character_id] = portrait
		portrait_id_to_character[portrait.get_instance_id()] = Character.from_id(character_id)
		portrait.target_position.x = 8 + index*TurnOrderPortrait.WIDTH
		portrait.target_position.y = 16 if index == 0 else 8
		portrait.visible = true
		portrait.target_visible = true
		updated_portraits[portrait.get_instance_id()] = portrait
		index += 1
	
	for portrait in updated_portraits.values():
		portrait.update()
