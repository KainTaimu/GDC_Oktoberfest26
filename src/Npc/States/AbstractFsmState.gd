@abstract
class_name AbstractFsmState
extends Node2D

enum States { NONE, IDLE, WORKING, WAITING_FOR_WORK, BUYING, GOING_HOME }

const STATE_NAMES: Dictionary[States, StringName] = {
	States.IDLE: &"idle",
	States.WORKING: &"working",
	States.WAITING_FOR_WORK: &"waiting_for_work",
	States.BUYING: &"buying",
	States.GOING_HOME: &"going_home",
}

@export var state: States = States.NONE


@abstract
func start() -> void


@abstract
func end() -> void


@abstract
func process(delta: float) -> void


@abstract
func get_state_name() -> StringName
