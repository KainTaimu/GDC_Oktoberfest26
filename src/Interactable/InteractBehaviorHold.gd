@tool
class_name InteractBehaviorHold
extends AbstractInteractBehavior

func on_press():
	active = true


func on_release():
	active = false


func reset():
	active = false
