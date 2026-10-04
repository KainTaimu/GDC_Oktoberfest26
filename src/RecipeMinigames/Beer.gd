@tool
extends Control

@export var minigame: AbstractRecipeMinigame

@export var color: Color

@export var time_to_complete: float = 1
@export_range(0, 1) var progress: float:
	get:
		return progress
	set(v):
		progress = clampf(v, 0, 1)
		rect.position.y = size.y - progress * size.y
		rect.size.y = (progress * size.y)
		queue_redraw()
@export var on: bool

var rect: Rect2


func _ready() -> void:
	Callable(func(): rect = Rect2(Vector2.ZERO, Vector2(size.x, 0))).call_deferred()


func _process(delta: float) -> void:
	if not on:
		return
	progress += delta / maxf(0.01, time_to_complete)
	if Engine.is_editor_hint():
		return
	if progress < 1:
		return
	minigame.on_minigame_completed.emit(true)
	minigame.queue_free()


func _draw() -> void:
	draw_rect(rect, color)


func _turn_on() -> void:
	on = true
