@abstract
class_name LevelEvent
extends Node

@export var autostart: bool


func _ready() -> void:
	if autostart:
		start()


@abstract
func start()


@abstract
func stop()
