@tool
extends MeshInstance3D
class_name SpellParticleMesh

@export_range(0, 1, 0.01)
var opacity: float = 1.0:
	set(v):
		if get_surface_override_material_count() > 0:
			var mat = get_surface_override_material(0)
			if mat is StandardMaterial3D:
				mat.albedo_color.a = v
	get:
		if get_surface_override_material_count() > 0:
			var mat = get_surface_override_material(0)
			if mat is StandardMaterial3D:
				return mat.albedo_color.a
		return 0.0
