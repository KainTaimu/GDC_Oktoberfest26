class_name PlayerHeldIngredient
extends Node

@export var _held_ingredient: Ingredient
@export var label: RichTextLabel

var held_ingredient: Ingredient:
	get:
		return _held_ingredient


## get the currently held ingredient. may be null if not holding anything
func get_held_ingredient() -> Ingredient:
	return held_ingredient


## Set the currently held ingredient with ingredient. May be null to clear the held ingredient
func try_set_held_ingredient(ingredient: Ingredient) -> bool:
	if _held_ingredient != null && ingredient != null:
		CustomLogger.log_debug("cant set ingredient: current holding another ingredient")
		return false

	if ingredient == null:
		if _held_ingredient != null:
			_held_ingredient.queue_free()
			_held_ingredient = null
		return true

	if _held_ingredient != null:
		_held_ingredient.queue_free()
	assert(not ingredient.is_inside_tree(), "expected ingredient to not already be in scene tree")
	_held_ingredient = ingredient
	add_child(_held_ingredient)
	return true


# PERF: Expensive polling
func _physics_process(_delta: float) -> void:
	if held_ingredient != null:
		label.text = held_ingredient.ingredient_name
	else:
		label.text = ""


func _to_string() -> String:
	return "PlayerHeldIngredient(%s)" % held_ingredient
