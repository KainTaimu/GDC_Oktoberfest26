@tool
@abstract
class_name AbstractInteractBehavior
extends Resource

var active: bool


func _init() -> void:
	resource_local_to_scene = true


@abstract
func on_press()


@abstract
func on_release()

@abstract
func reset()