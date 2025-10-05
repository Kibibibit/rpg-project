extends Node3D
class_name BattleCamera

var context: BattleContext

@onready
var camera: Camera3D = %Camera3D

var target_position: Vector3 = Vector3.ZERO
var target_rotation: Vector3 = Vector3.ZERO

func _ready() -> void:
	context = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	
	SignalBus.Battle.turn_started.connect(_on_turn_start)
	SignalBus.Battle.target_characters.connect(_on_target_characters)
	target_position = self.global_position
	target_rotation = self.global_rotation


func _on_turn_start(p_char_id: int) -> void:
	var actor: BattleActor = context.battle_actors[p_char_id]
	var team: Team.Type = context.team_map[p_char_id]
	
	
	var target := get_target_position(get_target_from_team(Team.ENEMY if team == Team.PLAYER else Team.PLAYER))
	self.target_position = actor.get_center_of_mass_global_position()
	aim_at(target)


func aim_at(p_position: Vector3) -> void:
	var prev_x: float = self.global_rotation.x
	var prev_z: float = self.global_rotation.z
	var prev_y: float = self.global_rotation.y
	
	look_at(p_position)
	self.global_rotation.x = prev_x
	self.global_rotation.z = prev_z
	self.target_rotation = self.global_rotation
	self.global_rotation.y = prev_y

func get_target_from_team(p_team: Team.Type) -> Array[int]:
	var out: Array[int] = []
	for target_id in context.team_map.keys():
		if context.team_map[target_id] == p_team:
			out.append(target_id)
	return out

func get_target_position(p_target_ids: Array[int]) -> Vector3:
	var avg: Vector3 = Vector3(0,0,0)
	var count: int = 0
	for target_id in p_target_ids:
		avg += context.battle_actors[target_id].get_center_of_mass_global_position()
		count += 1
	avg /= count
	return avg

func _on_target_characters(p_character_ids: Array[int]) -> void:
	aim_at(get_target_position(p_character_ids))

func _process(delta: float) -> void:
	var pos_diff: float = self.global_position.distance_to(self.target_position)
	var angle_diff: float = self.global_rotation.angle_to(self.target_rotation)
	if pos_diff > 5 or angle_diff > PI/4.0:
		self.global_position = self.target_position
		self.global_rotation = self.target_rotation
	else:
		self.global_position = self.global_position.move_toward(self.target_position, delta*10.0)
		self.global_rotation = self.global_rotation.slerp(self.target_rotation, delta*PI*2.0)
