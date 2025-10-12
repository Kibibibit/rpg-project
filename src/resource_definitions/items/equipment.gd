@abstract
@icon("res://resource/icons/equipment.png")
extends Item
class_name Equipment

@export
var stat_bonuses: Dictionary[Stats.Type, int] = {}
