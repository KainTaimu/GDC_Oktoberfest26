extends Node2D

var active: bool


func _process(_delta: float) -> void:
	pass


func _on_interaction_prompt_on_interacted() -> void:
	active = !active
