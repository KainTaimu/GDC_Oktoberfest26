class_name LevelRecipeData
extends Node

@export var recipe_queue: Array[FoodRecipe] = []

var current_recipe: FoodRecipe:
	get:
		return current_recipe
	set(v):
		current_recipe = v
		CustomLogger.log_debug("Current recipe changed to %s" % current_recipe)


func _ready() -> void:
	if len(recipe_queue) == 0:
		CustomLogger.log_warning("No recipe in queue")
		return
	current_recipe = recipe_queue.pop_front()
