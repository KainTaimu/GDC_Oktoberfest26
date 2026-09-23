@tool
extends AbstractProgress

@export var centered: bool:
	get:
		return centered
	set(v):
		centered = v
		if !v:
			grow_from_center = false
		queue_redraw()
@export var grow_from_center: bool:
	get:
		return grow_from_center
	set(v):
		if v:
			centered = true
		grow_from_center = v
		queue_redraw()
@export var inverted_progress: bool:
	get:
		return inverted_progress
	set(v):
		inverted_progress = v
		queue_redraw()
@export var size: Vector2 = Vector2(128, 8):
	get:
		return size
	set(v):
		size = v
		queue_redraw()


func _draw() -> void:
	var p := progress if not inverted_progress else 1.0 - progress
	var rect := Rect2()
	if grow_from_center:
		rect.position = Vector2(-size.x * p * 0.5, 0)
	else:
		rect.position = Vector2(-size.x * (0.5 if centered else 0.0), 0)
	rect.size = Vector2(size.x * p, size.y)
	draw_rect(rect, color, true, -1)
