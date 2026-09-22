@tool
class_name InteractBehaviorToggle
extends AbstractInteractBehavior

func on_press():
	active = !active


func on_release():
	pass


func reset():
	active = false
