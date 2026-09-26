class_name StationPathing

static func get_closest_station(p: Vector2, station_type: AbstractStation.Types, tree: SceneTree) -> AbstractStation:
	var group := tree.get_nodes_in_group("stations")
	if len(group) == 0:
		return null

	assert(group as Array[AbstractStation], "expected group stations to be all Node2Ds")
	var target_stations := group.filter(func(s: AbstractStation): return s.station_type == station_type)
	if len(target_stations) == 0:
		return null

	sort_custom(target_stations, _sort_by_dist_sq, p)
	assert(not target_stations.any(func(x): return x == null), "stations contains null")
	return target_stations[0]


## Sorts array in place using comparison `fn`, which receives the two elements and `c`.
static func sort_custom(arr: Array, fn: Callable, c: Vector2) -> void:
	arr.sort_custom(func(a, b): return fn.call(a, b, c))


## Sorts by distance squared to a point c
static func _sort_by_dist_sq(a: Node2D, b: Node2D, c: Vector2) -> bool:
	return a.global_position.distance_squared_to(c) < b.global_position.distance_squared_to(c)
