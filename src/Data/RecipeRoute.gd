class_name RecipeRoute
extends Resource

@export var station_work_list: Array[AbstractStation.Types] = []

var length: int:
	get:
		return len(station_work_list)


func get_station(idx: int) -> AbstractStation.Types:
	return station_work_list[idx]
