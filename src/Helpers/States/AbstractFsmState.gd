@abstract
class_name AbstractFsmState
extends Node2D

@abstract
func start() -> void


@abstract
func end() -> void


@abstract
func process(delta: float) -> void


@abstract
func get_state_name() -> StringName
