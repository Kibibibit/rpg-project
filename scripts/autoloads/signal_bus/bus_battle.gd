extends Node
class_name BusBattle

@warning_ignore_start("unused_signal")
signal started()

signal round_started(s_round_number: int)

signal turn_started(s_character_id: int)

signal show_action_menu()

signal hide_action_menu()

signal skill_selected(s_skill_id: int)
