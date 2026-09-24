@abstract
class_name AbstractStation
extends Node2D

signal on_progress_changed(new_value: float)

enum Types { NONE, CHOPPING_BOARD, COOKING_POT }

@export var station_type: Types


func _on_interaction_prompt_on_interacted() -> void:
	interact()


@abstract
func interact() -> void
