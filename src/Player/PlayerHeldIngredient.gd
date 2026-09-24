class_name PlayerHeldIngredient
extends Node

@export var held_ingredient: Ingredient:
	get:
		return _held_ingredient
	set(v):
		_on_held_ingredient_changed.call_deferred(v)

@export var label: RichTextLabel

var _held_ingredient: Ingredient


func _on_held_ingredient_changed(new_ingredient: Ingredient):
	if held_ingredient != null && held_ingredient.on_changed.is_connected(_set_label):
		held_ingredient.on_changed.disconnect(_set_label.bind(_held_ingredient.ingredient_name))

	_held_ingredient = new_ingredient
	if _held_ingredient != null:
		_held_ingredient.on_changed.connect(_set_label.bind(_held_ingredient.ingredient_name))
		_set_label(_held_ingredient.ingredient_name)


func _set_label(s: String):
	label.text = s


func _to_string() -> String:
	return "PlayerHeldIngredient(%s)" % held_ingredient
