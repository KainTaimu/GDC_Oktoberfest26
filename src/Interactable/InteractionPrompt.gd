@tool
class_name InteractionPrompt
extends Node2D

signal on_interacted

@export var interact_behavior: AbstractInteractBehavior

var progress: float:
	get:
		return progress
	set(v):
		progress = clampf(v, 0, 1)
		queue_redraw()
@export var progress_radius: float = 128:
	get:
		return progress_radius
	set(v):
		progress_radius = v
		queue_redraw()
@export var progress_hint_radius: float = 8:
	get:
		return progress_hint_radius
	set(v):
		progress_hint_radius = v
		queue_redraw()

@export var progress_color: Color = Color.WHITE:
	get:
		return progress_color
	set(v):
		progress_color = v
		_color = v
		queue_redraw()

@export var time_to_complete: float = 0.5

var _color: Color = Color.TRANSPARENT
var _mouse_in_area: bool
var _cooldown: bool


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if not _cooldown:
		var was_complete := progress >= 1.0
		progress += (delta if interact_behavior.active else -delta) * (1 / time_to_complete)

		if progress >= 1.0 and not was_complete:
			on_interacted.emit()

	queue_redraw()


func _input(event: InputEvent) -> void:
	var button := event as InputEventMouseButton
	if button == null:
		return
	if button.is_pressed() && _mouse_in_area:
		interact()
	elif button.is_released():
		interact_behavior.on_release()


func _draw() -> void:
	if not _mouse_in_area:
		draw_circle(Vector2.ZERO, progress_hint_radius, progress_color, true, -1, true)
	else:
		# background
		draw_circle(Vector2.ZERO, progress_radius, Color(_color, _color.a * 0.1), true, -1, true)
		# inner circle
		draw_circle(Vector2.ZERO, progress_radius * progress, _color, true, -1, true)
		# outer ring
		draw_circle(Vector2.ZERO, progress_radius, _color, false, 1, true)


func interact():
	interact_behavior.on_press()


func _show_progress():
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "_color", progress_color, time_to_complete)
	_mouse_in_area = true


func _hide_progress():
	_cooldown = true
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "_color", Color.TRANSPARENT, time_to_complete)
	tween.tween_callback(func(): _cooldown = false)
	_mouse_in_area = false


func _on_interacted() -> void:
	_reset()


func _reset():
	var tween := create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "_color", Color.TRANSPARENT, time_to_complete)
	tween.tween_callback(_reset_progress)


func _reset_progress():
	progress = 0
	interact_behavior.reset()
