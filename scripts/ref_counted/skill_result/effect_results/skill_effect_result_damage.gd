extends SkillEffectResult
class_name SkillEffectResultDamage


var hits: Array[DamageResult] = []
var intended_target_id: int = -1
var any_crit: bool = false
var blocked: bool = false
var target_affinity: Affinity.Type = Affinity.NORMAL
## TODO: Track block, weak, so on


func get_type() -> Type:
	return Type.DAMAGE
