extends Node
class_name BusBattle

@warning_ignore_start("unused_signal")
signal started()

signal spawn_actor(s_character_id: int, s_team: Team.Type)

signal round_started(s_round_number: int)

signal turn_started(s_character_id: int)

signal back()

signal show_action_menu()

signal hide_action_menu()

signal action_selected(s_action: Action.Type)

signal show_skill_menu()

signal hide_skill_menu()

signal skill_selected(s_skill: Skill)

signal show_target_menu()

signal hide_target_menu()

signal target_characters(s_character_ids: Array[int])

signal targets_selected(s_character_ids: Array[int])
