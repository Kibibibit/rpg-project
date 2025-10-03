extends Control
class_name DamageNumberParent

var damage_numbers: Dictionary[int, DamageDisplay] = {}

func _ready() -> void:
	SignalBus.Battle.add_damage_display.connect(_on_spawn_actor)
	


func _on_spawn_actor(p_character_id: int) -> void:
	damage_numbers[p_character_id] = DamageDisplay.create(p_character_id)
	add_child(damage_numbers[p_character_id])
