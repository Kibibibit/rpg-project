extends Node3D
class_name BattleActor

const GROUP: String = "battle_actors"

signal skill_finished

@export
var control_mode: CharacterControlMode.Type = CharacterControlMode.PLAYER
@export
var character_data: CharacterData

var buffs: BuffModifiers = BuffModifiers.new()

@export
var alive: bool = true

var hp: int:
	get:
		return character_data.hp
	set(v):
		character_data.hp = v

var mp: int:
	get:
		return character_data.mp
	set(v):
		character_data.mp = v



var strength: int:
	get:
		return character_data.strength
var magic: int:
	get:
		return character_data.magic
var defense: int:
	get:
		return character_data.defense
var agility: int:
	get:
		return character_data.agility
var luck: int:
	get:
		return character_data.luck

func get_initiative() -> int:
	return character_data.get_initiative()


func execute_skill(skill: Skill, targets: Array[BattleActor] = []) -> void:
	## TODO: Run skills
	skill_finished.emit.call_deferred()

func trigger_select_skill() -> void:
	## TODO: Add an AI and player control nodes
	pass


	

func _ready() -> void:
	add_to_group(GROUP)
	
