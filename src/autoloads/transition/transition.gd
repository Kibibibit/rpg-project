extends Node


const DEFAULT_DURATION: float = 0.2
const PAUSE_TIME: float = 0.1

enum Type {
	WIPE_IN,
	WIPE_OUT,
	FADE_IN,
	FADE_OUT
}

var _anim_names: Dictionary[Type, String] = {
	Type.WIPE_IN: "transitions/wipe_in",
	Type.WIPE_OUT: "transitions/wipe_out",
	Type.FADE_IN: "transitions/fade_in",
	Type.FADE_OUT: "transitions/fade_out"
}

const TransitionScene = preload("uid://cfqr130uv5get")


var scene: TransitionScene

func _ready() -> void:
	var transition_packed_scene = UIDLookup.load_packed_scene(&"prefab/transition_scene")
	scene = transition_packed_scene.instantiate()
	add_child(scene)



func play(type: Type, duration: float = DEFAULT_DURATION, pause_in: bool = false, pause_out: bool = false) -> void:
	if pause_in:
		scene.timer.start(PAUSE_TIME)
		await scene.timer.timeout
	if duration <= 0.0:
		push_error("Duration must be greater than 0")
		return
	scene.animation_player.speed_scale = 1.0 / duration
	if _anim_names.has(type):
		scene.animation_player.play(_anim_names[type])
		await scene.animation_player.animation_finished
		if pause_out:
			scene.timer.start(PAUSE_TIME)
			await scene.timer.timeout
	else:
		push_error("No animation found for type: %s" % str(type))

func wipe_in(duration: float = DEFAULT_DURATION) -> void:
	await play(Type.WIPE_IN, duration, false, true)

func wipe_out(duration: float = DEFAULT_DURATION) -> void:
	await play(Type.WIPE_OUT, duration, true, false)

func fade_in(duration: float = DEFAULT_DURATION) -> void:
	await play(Type.FADE_IN, duration, false, true)

func fade_out(duration: float = DEFAULT_DURATION) -> void:
	await play(Type.FADE_OUT, duration, true, false)
