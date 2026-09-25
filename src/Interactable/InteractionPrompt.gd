@tool
class_name InteractionPrompt
extends Node2D

signal on_interacted

@export var interact_behavior: AbstractInteractBehavior
@export var area: CollisionShape2D

@export var radius: float = 24:
	get:
		return radius
	set(v):
		radius = v
		var change_shape_radius := func():
			area.shape.radius = radius
		change_shape_radius.call_deferred()

var progress: float:
	get:
		return progress
	set(v):
		progress = clampf(v, 0, 1)
		queue_redraw()
@export var progress_radius: float = 32:
	get:
		return progress_radius
	set(v):
		progress_radius = v
		queue_redraw()
@export var progress_color: Color = Color.WHITE:
	get:
		return progress_color
	set(v):
		progress_color = v
		_color = v
		queue_redraw()

@export var time_to_complete: float = 0.5
@export var show_time: float = 1.0
@export var interaction_cooldown: float = 1

@export_category("Debug")
@export var _show_hints: bool = false:
	get:
		return _show_hints
	set(v):
		_show_hints = v
		queue_redraw()

var _color: Color = Color.TRANSPARENT
var _mouse_in_area: bool
var _interaction_cooldown: float:
	get:
		return _interaction_cooldown
	set(v):
		_interaction_cooldown = max(0, v)


func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if _interaction_cooldown > 0:
		_interaction_cooldown -= delta
	else:
		var was_complete := progress >= 1.0
		progress += (delta if interact_behavior.active else -delta) * (1 / time_to_complete)

		if progress >= 1.0 and not was_complete:
			on_interacted.emit()


func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
	if _interaction_cooldown > 0:
		return

	var button := event as InputEventMouseButton
	if button == null:
		return
	if button.is_pressed() && _mouse_in_area:
		interact()
	elif button.is_released():
		interact_behavior.on_release()


func disable():
	$Area2D.process_mode = ProcessMode.PROCESS_MODE_DISABLED


func _draw() -> void:
	# background
	draw_circle(Vector2.ZERO, progress_radius, Color(_color, _color.a * 0.1), true, -1, true)
	# inner circle
	draw_circle(Vector2.ZERO, progress_radius * progress, _color, true, -1, true)
	# outer ring
	draw_circle(Vector2.ZERO, progress_radius, _color, false, 1, true)
	if Engine.is_editor_hint() && _show_hints:
		# outer ring editor hint
		draw_circle(Vector2.ZERO, progress_radius, Color.GREEN, false, 1, false)


func interact():
	interact_behavior.on_press()


func _show_progress():
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "_color", progress_color, show_time)
	_mouse_in_area = true


func _hide_progress():
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(self, "_color", Color.TRANSPARENT, show_time)
	_mouse_in_area = false


func _on_interacted() -> void:
	_interaction_cooldown = interaction_cooldown
	_reset()


func _reset():
	var tween := create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "_color", Color.TRANSPARENT, show_time)
	tween.tween_callback(_reset_progress)
	_mouse_in_area = false


func _reset_progress():
	progress = 0
	interact_behavior.reset()
