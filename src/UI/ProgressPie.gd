@tool
extends AbstractProgress

@export var radius: float = 64:
	get:
		return radius
	set(v):
		radius = v
		queue_redraw()


func _draw() -> void:
	if progress <= 0.0:
		return

	var center := Vector2.ZERO
	var points: PackedVector2Array = []
	points.append(center)

	var start_angle := -PI / 2.0
	var end_angle := start_angle + (TAU * progress)
	var segments := int(64 * progress) + 2

	for i in range(segments):
		var t := float(i) / float(segments - 1)
		var angle = lerp(start_angle, end_angle, t)
		points.append(center + Vector2(cos(angle), sin(angle)) * radius)

	draw_colored_polygon(points, color)
