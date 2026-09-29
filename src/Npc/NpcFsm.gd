class_name NpcFsm
extends Node2D

@export var target: Node2D
@export var current_state: AbstractFsmState


func _ready() -> void:
	if current_state == null:
		return
	current_state.start()


func _physics_process(delta: float) -> void:
	if current_state == null:
		return
	current_state.process(delta)


func transition(new_state: AbstractFsmState.States) -> void:
	CustomLogger.log_debug(
		"npc %s<%s> fsm transitioning from \"%s\" to \"%s\"" % [
			target.name,
			get_instance_id(),
			AbstractFsmState.STATE_NAMES[current_state.state],
			AbstractFsmState.STATE_NAMES[new_state],
		],
	)
	if current_state != null:
		current_state.end()

	var children := get_children()
	var state := children.find_custom(func(x: AbstractFsmState): return x.state == new_state)
	assert(state != null, "State %s not found" % new_state)
	current_state = children[state] as AbstractFsmState
	current_state.start()
