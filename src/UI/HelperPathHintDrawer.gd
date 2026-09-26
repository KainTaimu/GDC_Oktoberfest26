class_name HelperPathHintDrawer
extends Node2D

@export var routes: RecipeRoute
var enabled: bool
var paths: Array[Vector2] = []


func set_routes(r: RecipeRoute) -> void:
	enabled = r != null
	process_mode = PROCESS_MODE_INHERIT if enabled else PROCESS_MODE_DISABLED
	routes = r


func _input(_event: InputEvent) -> void:
	if not enabled or not is_inside_tree():
		return
	paths.clear()

	var nav_rid := get_world_2d().navigation_map
	assert(nav_rid != RID(), "No navigation map")

	var vp := get_viewport()
	var cam := vp.get_camera_2d()

	var origin: Vector2 = cam.get_local_mouse_position() * cam.get_canvas_transform().affine_inverse()
	var from: Vector2 = origin
	for station in routes.station_work_list:
		var closest := StationPathing.get_closest_station(origin, station, get_tree())
		if closest == null:
			continue

		var to := closest.global_position * cam.get_canvas_transform().affine_inverse()
		CustomLogger.log_debug("from: %s, to: %s" % [from, to])

		var world_path := NavigationServer2D.map_get_path(
			nav_rid,
			from,
			to,
			true,
		)
		paths.append_array(world_path)
		from = to

	queue_redraw()


func _draw() -> void:
	if len(paths) <= 2:
		return
	draw_polyline(paths, Color.GREEN, 1.5)
