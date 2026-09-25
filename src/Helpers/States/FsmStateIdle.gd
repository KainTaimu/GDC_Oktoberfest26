class_name FsmStateIdle
extends AbstractFsmState

@export var _state_name: StringName = &"idle"


func start() -> void:
	pass


func end() -> void:
	pass


func process(_delta: float):
	pass


func get_state_name() -> StringName:
	return _state_name
