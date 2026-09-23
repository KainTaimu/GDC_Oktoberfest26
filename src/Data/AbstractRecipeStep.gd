@abstract
class_name AbstractRecipeStep
extends Resource

@abstract
func start_minigame()


func mark_complete():
	pass


func _to_string() -> String:
	return "%s : " % get_class()
