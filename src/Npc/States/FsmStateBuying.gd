class_name FsmStateBuying
extends AbstractFsmState

@export var _state_name: StringName = &"buying"
@export var owner_node: Npc

@export var station_routes: RecipeRoute
@export var fsm_manager: NpcFsm

var navigation_agent: NavigationAgent2D
var station_idx: int
var current_target: AbstractStation


func _ready() -> void:
	navigation_agent = NavigationAgent2D.new()
	navigation_agent.avoidance_enabled = true
	navigation_agent.velocity_computed.connect(_on_velocity_computed)
	add_child(navigation_agent)
	navigation_agent.process_mode = ProcessMode.PROCESS_MODE_DISABLED


func _on_velocity_computed(safe_velocity: Vector2):
	owner_node.velocity = safe_velocity
	owner_node.move_and_slide()
	owner_node.sprite.flip_h = owner_node.velocity.x < 0


func start() -> void:
	navigation_agent.process_mode = ProcessMode.PROCESS_MODE_INHERIT


func end() -> void:
	navigation_agent.process_mode = ProcessMode.PROCESS_MODE_DISABLED


func process(_delta: float):
	if station_routes == null:
		fsm_manager.transition(States.GOING_HOME)
		return
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		if current_target != null:
			current_target.interact_forced()
		if station_idx >= station_routes.length:
			fsm_manager.transition(States.GOING_HOME)
			return

		var target_station := station_routes.get_station(station_idx)
		var closest := StationPathing.get_random_station(target_station, get_tree())
		if closest == null:
			CustomLogger.log_debug("no station \"%s\" found" % AbstractStation.TYPE_NAMES[target_station])
			fsm_manager.transition(States.GOING_HOME)
			return

		current_target = closest
		navigation_agent.set_target_position(closest.global_position)
		if station_idx == station_routes.length:
			CustomLogger.log_debug("last station visited")
			fsm_manager.transition(States.GOING_HOME)
			return
		station_idx += 1
		return

	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * owner_node.move_speed.value
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)


func get_state_name() -> StringName:
	return _state_name
