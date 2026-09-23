@tool
@abstract
class_name AbstractProgress
extends Node2D

@export_range(0.0, 1.0) var progress: float:
	get:
		return progress
	set(v):
		progress = clamp(v, 0.0, 1.0)
		queue_redraw()
@export var color: Color = Color.WHITE:
	get:
		return color
	set(v):
		color = v
		queue_redraw()


func set_progress(value: float) -> void:
	progress = value
