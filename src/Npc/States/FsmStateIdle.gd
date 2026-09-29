class_name FsmStateIdle
extends AbstractFsmState

@export var _state_name: StringName = &"idle"
@export var owner_node: CharacterBody2D


func start() -> void:
	pass


func end() -> void:
	pass


func process(_delta: float):
	print(owner_node.velocity)
	pass


func get_state_name() -> StringName:
	return _state_name
