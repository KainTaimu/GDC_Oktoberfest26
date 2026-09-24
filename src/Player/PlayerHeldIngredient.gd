class_name PlayerHeldIngredient
extends Node

@export var held_ingredient: Ingredient:
	get:
		return _held_ingredient
	set(v):
		_held_ingredient = v

@export var label: RichTextLabel

var _held_ingredient: Ingredient


# PERF: Expensive polling
func _physics_process(_delta: float) -> void:
	if held_ingredient != null:
		label.text = held_ingredient.ingredient_name
	else:
		label.text = ""


func _to_string() -> String:
	return "PlayerHeldIngredient(%s)" % held_ingredient
