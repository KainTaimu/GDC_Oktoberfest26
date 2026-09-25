class_name HelperFsm
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
	if current_state != null:
		current_state.end()

	var children := get_children()
	var state := children.find_custom(func(x: AbstractFsmState): return x.state == new_state)
	assert(state != null, "State %s not found" % new_state)
	current_state = children[state] as AbstractFsmState
	current_state.start()
