class_name FsmStateWaitingForWork
extends AbstractFsmState

signal on_work_started
signal on_work_finished

@export var _state_name: StringName = &"waiting_for_work"
@export var work_state: FsmStateGotoStation
@export var station_routes: RecipeRoute

@onready var fsm_manager: HelperFsm = $".."


func start() -> void:
	on_work_started.emit()


func end() -> void:
	on_work_finished.emit()


func process(_delta: float):
	if Engine.get_physics_frames() % 60 != 0:
		return
	var conditions_met := _check_conditions()
	if conditions_met:
		fsm_manager.transition(AbstractFsmState.States.WORKING)


func get_state_name() -> StringName:
	return _state_name


func _check_conditions() -> bool:
	for station_route in station_routes.station_work_list:
		var group := get_tree().get_nodes_in_group("stations")
		if len(group) == 0:
			return false

		assert(group as Array[AbstractStation], "expected group stations to be all Node2Ds")
		var target_stations := group.filter(func(s: AbstractStation): return s.station_type == station_route)
		if len(target_stations) == 0:
			return false
	return true


func _sort_by_dist_sq(a: Node2D, b: Node2D) -> bool:
	return a.global_position.distance_squared_to(global_position) < b.global_position.distance_squared_to(global_position)
