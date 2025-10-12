extends Node


const DATA: Dictionary[StringName, String] = {
#region skills
	&"skill/nothing": "uid://bwcg2vyfmyxn1",
	#region basic
		&"skill/basic/attack-slash": "uid://dysameacfy8po",
		&"skill/basic/attack-blunt": "uid://drjdom7ctslnj",
		&"skill/basic/attack-pierce": "uid://38xdu7lbv8kc",
	#endregion basic
	#region fire
		&"skill/fire/small": "uid://ddlq5sgm3okit",
	#endregion
#endregion skills

#region characterdefs
	&"chardef/test/a": "uid://boq4y7ntw7cuv",
	&"chardef/test/b": "uid://bb2cq86tuk5m8",
	&"chardef/test/c": "uid://dd82iobddd66e",
	&"chardef/test/d": "uid://bk082yx7r2yg6",
#endregion characterdefs

#region prefabs
	#region battle
		&"prefab/battle/battle-actor": "uid://wc1rwu8trdg0",
	#endregion battle
	#region ui
		&"prefab/ui/select": "uid://clm87rug7ywg7",
	#endregion ui
	&"prefab/transition_scene": "uid://chc5yt1u6uaje",
#endregion prefabs

#region skins
		&"skin/test": "uid://drylx2maxpbvq",
#endregion

#region backdrops
	&"backdrop/test": "uid://cgkk16pwss3vn"
#endregion
}


func get_uid(id: StringName) -> String:
	if id in DATA:
		return DATA[id]
	else:
		push_error("No UID found for ID: %s" % str(id))
		return ""

func load_resource(id: StringName) -> Resource:
	var uid := get_uid(id)
	if uid == "":
		return null
	
	var res: Resource = ResourceLoader.load(uid)
	if res == null:
		push_error("Failed to load resource for UID: %s" % str(uid))
		return null
	return res

func load_packed_scene(id: StringName) -> PackedScene:
	var res := load_resource(id)
	if res == null:
		return null
	var scene := res as PackedScene
	if scene == null:
		push_error("Resource for ID: %s is not a PackedScene" % str(id))
		return null
	return scene

func load_character_definition(id: StringName) -> CharacterDefinition:
	var res := load_resource(id)
	if res == null:
		return null
	var char_def := res as CharacterDefinition
	if char_def == null:
		push_error("Resource for ID: %s is not a CharacterDefinition" % str(id))
		return null
	return char_def

func load_skill(id: StringName) -> Skill:
	var res := load_resource(id)
	if res == null:
		return null
	var skill := res as Skill
	if skill == null:
		push_error("Resource for ID: %s is not a Skill" % str(id))
		return null
	return skill
