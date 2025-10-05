extends Control
class_name DamageNumberParent

signal all_done

var damage_numbers: Dictionary[int, DamageDisplay] = {}
var waiting_on: Array[int] = []
var started: bool = false

func _ready() -> void:
	SignalBus.Battle.add_damage_display.connect(_on_spawn_actor)
	SignalBus.Battle.deal_hit.connect(_on_deal_hit)


func _on_spawn_actor(p_character_id: int) -> void:
	damage_numbers[p_character_id] = DamageDisplay.create(p_character_id)
	add_child(damage_numbers[p_character_id])

func _on_deal_hit(p_character_id: int, p_amount: int):
	if p_character_id not in damage_numbers.keys():
		return
	
	if not started:
		started = true
	
	if not p_character_id in waiting_on:
		waiting_on.append(p_character_id)
		damage_numbers[p_character_id].done.connect(_on_damage_display_done, CONNECT_ONE_SHOT)
	damage_numbers[p_character_id].deal_hit(p_amount)


func _on_damage_display_done(p_character_id: int) -> void:
	if p_character_id in waiting_on:
		waiting_on.erase(p_character_id)
	if len(waiting_on) == 0:
		started = false
		all_done.emit()
