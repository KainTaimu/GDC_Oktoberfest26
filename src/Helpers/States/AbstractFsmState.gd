@abstract
class_name AbstractFsmState
extends Node2D

enum States { NONE, IDLE, WORKING, WAITING_FOR_WORK }

@export var state: States = States.NONE


@abstract
func start() -> void


@abstract
func end() -> void


@abstract
func process(delta: float) -> void


@abstract
func get_state_name() -> StringName
