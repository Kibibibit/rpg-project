extends Node

@onready
var state_machine: StateStackManager = %StateStackManager

func _ready() -> void:
	var char_def_a: CharacterDefinition = preload("uid://bwgtemof3tvb2")
	var char_def_b: CharacterDefinition = preload("uid://cwqxuvikseuo0")

	ContextManager.create_context(Context.Type.BATTLE)
	var context: BattleContext = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	context.add_characters([
		Character.from_definition(char_def_a)
	],
	Team.Type.PLAYER)
	context.add_characters([
		Character.from_definition(char_def_b)
	],
	Team.Type.ENEMY)


func _process(_delta: float) -> void:
	state_machine.step()

func _exit_tree() -> void:
	ContextManager.destroy_context(Context.Type.BATTLE)
