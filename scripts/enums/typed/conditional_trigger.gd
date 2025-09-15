extends RefCounted
class_name ConditionalTrigger

enum _ConditionalTriggerType {
	ON_HIT,
	ON_CRIT,
	ON_WEAKNESS,
	ON_RESIST
}

const Type = _ConditionalTriggerType

const ON_HIT := Type.ON_HIT
const ON_CRIT := Type.ON_CRIT
const ON_WEAKNESS := Type.ON_WEAKNESS
const ON_RESIST := Type.ON_RESIST
