@tool
extends Control

@export var color: Color

@onready var size_x: float = get_parent().size.x

@export var progress: float:
	get:
		return progress
	set(v):
		progress = clampf(v, 0, 1)
		label.text = "%s%%" % roundi(progress * 100)
		queue_redraw()
		if progress >= 1:
			minigame.on_minigame_completed.emit(true)
			minigame.queue_free()

@export var minigame: AbstractRecipeMinigame
@export var label: Label


func _process(delta: float) -> void:
	queue_redraw()
	pass


func _input(event: InputEvent) -> void:
	var m := event as InputEventMouseMotion
	if m == null:
		return
	if m.relative.length_squared() < 16 * 16:
		return
	progress += get_process_delta_time()


func _draw() -> void:
	draw_circle(Vector2.ZERO, size_x * 0.5, color, true)
