extends Control
class_name DamageNumber


const _DAMAGE_NUMBER = preload("uid://cgv0ws87w15g3")

@onready var label: Label = %Label
var value: int = 0
var velocity: Vector2 = Vector2(0, -400)

static func create(p_value: int) -> DamageNumber:
	var instance := _DAMAGE_NUMBER.instantiate() as DamageNumber
	instance.value = p_value
	return instance

func _ready() -> void:
	label.text = "%d" % value
	velocity.x = randf_range(-50, 50)


func _process(delta: float) -> void:
	
	velocity.y += 12
	self.position += velocity*delta
	
	if not is_visible_in_tree():
		if not is_queued_for_deletion():
			self.queue_free()
			self.get_parent().remove_child(self)
