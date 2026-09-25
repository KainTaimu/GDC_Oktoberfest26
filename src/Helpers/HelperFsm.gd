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
