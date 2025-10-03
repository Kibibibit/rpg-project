extends Control
class_name DamageDisplay

const _PACKED_SCENE = preload("uid://tfwg8fhia7mk")
@onready var progress_bar: ProgressBar = %ProgressBar


static func create(p_character_id: int) -> DamageDisplay:
	var out := _PACKED_SCENE.instantiate() as DamageDisplay
	out.character_id = p_character_id
	return out

var character_id: int
var battle_actor: BattleActor
var context: BattleContext

var current_hp: float
var max_hp: float

var _visible_tween: Tween
var _bar_tween: Tween

func _ready() -> void:
	visible = false
	context = ContextManager.get_context(Context.Type.BATTLE) as BattleContext
	battle_actor = context.battle_actors[character_id]
	## TODO: Access stats via a lookup for modifiers
	current_hp = float(context.get_character(character_id).hp)
	max_hp = float(context.get_character(character_id).stats.max_hp)
	progress_bar.value = current_hp/max_hp
	SignalBus.Battle.deal_hit.connect(_on_deal_hit)
	
func _process(_delta: float) -> void:
	if not visible:
		return
	self.position = get_viewport().get_camera_3d().unproject_position(battle_actor.get_center_of_mass_global_position())


func _on_deal_hit(p_character_id: int, p_amount: int) -> void:
	if p_character_id != character_id:
		return
	if not visible:
		progress_bar.value = current_hp/max_hp
		
	current_hp = max(current_hp - p_amount, 0)
	if _visible_tween:
		_visible_tween.kill()
	self.visible = true
	self.modulate = Color.WHITE
	_visible_tween = create_tween()
	_visible_tween.tween_interval(1.0)
	_visible_tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)
	_visible_tween.tween_callback(func(): self.visible = false)
	
	if _bar_tween:
		_bar_tween.kill()
	_bar_tween = create_tween()
	_bar_tween.tween_property(progress_bar, "value", current_hp/max_hp, 0.3)
	_bar_tween.play()
	_visible_tween.play()
	
	
