@icon("res://resource/icons/character_definition.png")
extends Resource
class_name CharacterDefinition


@export
var char_name: String

@export
var stats: Stats = Stats.new()

@export
var elemental_affinities: Dictionary[Element.Type, Affinity.Type] = {}

@export
var skin_id: StringName = &"skin/test"

@export var unarmed_attack_skill: StringName = &"skill/basic/attack-blunt"

@export
var innate_skills: Array[StringName] = []