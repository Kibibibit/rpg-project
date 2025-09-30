extends Node3D
class_name CharacterSkin

var center_of_mass: Node3D

func _ready() -> void:
	center_of_mass = _find_center_of_mass(self)
	if not center_of_mass:
		center_of_mass = self as Node3D


func _find_center_of_mass(p_node: Node) -> Node3D:
	for child in p_node.get_children():
		if child is Node3D and child.name == "CenterOfMass":
			return child as Node3D
		else:
			return _find_center_of_mass(child)
	return null
