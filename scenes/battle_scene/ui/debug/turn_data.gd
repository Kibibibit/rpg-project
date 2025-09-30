extends Label


func _process(_delta: float) -> void:
	if is_visible_in_tree():
		var context: BattleContext = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
		if not context:
			text = "Battle context missing!"
			return
		var lines: Array[String] = ["Current Turn Data:"]
		
		var current_character := context.get_current_character()
		if current_character:
			lines.append("Character: %s" % current_character.definition.name)
		var current_skill := context.current_skill
		if current_skill:
			lines.append("Skill: %s" % current_skill.name)
		
		var current_targets := context.current_targets
		if not current_targets.is_empty():
			lines.append("Targets:")
			for target_id in current_targets:
				lines.append("-%s" % context.get_character(target_id).definition.name)
		
		## TODO: Targeting
		
		text = "\n".join(lines)
	
