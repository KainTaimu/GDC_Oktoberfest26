@abstract
class_name AbstractStation
extends Node2D

signal on_progress_changed(new_value: float)


@abstract
func _on_interaction_prompt_on_interacted() -> void


@abstract
func interact() -> void
