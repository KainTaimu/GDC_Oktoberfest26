extends Node

@export var buying_state: FsmStateBuying


func _ready() -> void:
	var sell_stations := get_tree().get_nodes_in_group("stations_sell")
	if len(sell_stations) == 0:
		return
	assert(sell_stations as Array[AbstractStation], "expected group \"stations_sell\" to all be AbstractStation")
	var rand: = sell_stations.pick_random() as AbstractStation
	var routes := RecipeRoute.new()
	routes.station_work_list = [rand.station_type]
	buying_state.station_routes = routes
	queue_free()
