extends Node

@onready
var state_machine: StateStackManager = %StateStackManager


func _enter_tree() -> void:
	ContextManager.create_context(Context.Type.BATTLE)

func _ready() -> void:
	var char_def_a: CharacterDefinition = preload("uid://bwgtemof3tvb2")
	var char_def_b: CharacterDefinition = preload("uid://cwqxuvikseuo0")
	var char_def_c: CharacterDefinition = preload("uid://dyna37jccfwwk")
	var char_def_d: CharacterDefinition = preload("uid://cl85xu2t3ua3l")

	
	var context: BattleContext = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	context.add_characters([
		Character.from_definition(char_def_a),
		Character.from_definition(char_def_b)
	],
	Team.Type.PLAYER)
	context.add_characters([
		Character.from_definition(char_def_c),
		Character.from_definition(char_def_d)
	],
	Team.Type.ENEMY)
	
	state_machine.begin()


func _process(_delta: float) -> void:
	if ContextManager.context_exists(Context.Type.BATTLE):
		state_machine.step()

func _exit_tree() -> void:
	ContextManager.destroy_context(Context.Type.BATTLE)
