extends SkillEffectResult
class_name SkillEffectResultDamage

var caster: Character
var target: Character

var amount: int

var did_crit: bool
var did_miss: bool
var target_affinity: Affinity.Type
var blocked: bool


func _init(
	p_caster: Character,
	p_target: Character,
	p_amount: int,
	p_did_crit: bool,
	p_did_miss: bool,
	p_target_affinity: Affinity.Type,
	p_blocked: bool
) -> void:
	caster = p_caster
	target = p_target
	amount = p_amount
	did_crit = p_did_crit
	did_miss = p_did_miss
	target_affinity = p_target_affinity
	blocked = p_blocked

func get_type() -> Type:
	return Type.DAMAGE
