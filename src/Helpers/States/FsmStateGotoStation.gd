class_name FsmStateGotoStation
extends AbstractFsmState

@export var _state_name: StringName = &"goto_station"
@export var owner_node: CharacterBody2D
@export var station_routes: RecipeRoute
@export var move_speed: Stat

@onready var fsm_manager: HelperFsm = $".."

var navigation_agent: NavigationAgent2D
var station_idx: int
var queued_interaction: AbstractStation


func _ready() -> void:
	navigation_agent = NavigationAgent2D.new()
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	add_child(navigation_agent)


func _on_velocity_computed(safe_velocity: Vector2):
	owner_node.velocity = safe_velocity
	owner_node.move_and_slide()


func start() -> void:
	station_idx = 0
	var closest := _get_closest_station(station_routes.get_station(station_idx))
	navigation_agent.set_target_position(closest.global_position)


func end() -> void:
	fsm_manager.current_state = %"FsmStateIdle"


func process(_delta: float):
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		if queued_interaction != null:
			queued_interaction.interact_forced()
			queued_interaction = null

		station_idx = wrapi(station_idx + 1, 0, station_routes.length)
		var closest := _get_closest_station(station_routes.get_station(station_idx))
		navigation_agent.set_target_position(closest.global_position)

		if station_idx == station_routes.length - 1:
			queued_interaction = closest
		return

	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * move_speed.value
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)


func get_state_name() -> StringName:
	return _state_name


func _get_closest_station(station_type: AbstractStation.Types) -> AbstractStation:
	var group := get_tree().get_nodes_in_group("stations")
	if len(group) == 0:
		return null

	assert(group as Array[AbstractStation], "expected group stations to be all Node2Ds")
	var target_stations := group.filter(func(s: AbstractStation): return s.station_type == station_type)
	if len(target_stations) == 0:
		return null

	target_stations.sort_custom(_sort_by_dist_sq)
	return target_stations[0]


func _sort_by_dist_sq(a: Node2D, b: Node2D) -> bool:
	return a.global_position.distance_squared_to(global_position) < b.global_position.distance_squared_to(global_position)
