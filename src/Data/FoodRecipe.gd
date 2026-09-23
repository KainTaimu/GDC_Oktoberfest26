class_name FoodRecipe
extends Resource

@export var name: StringName
@export var description: StringName
@export var _steps: Array[AbstractRecipeStep] = []


func _init() -> void:
	resource_local_to_scene = true


func pop_step():
	var step: AbstractRecipeStep = _steps.pop_front()
	step.start_minigame()


func _to_string() -> String:
	return "FoodRecipe(%s)" % name
