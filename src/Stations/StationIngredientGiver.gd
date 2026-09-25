@tool
extends AbstractStation

@export var label_name: StringName:
	get:
		return label_name
	set(v):
		label_name = v
		_label.text = v
@export var gives: PackedScene

@export var _label: Label


func interact() -> void:
	var held := LevelData.main_player.held_ingredient
	assert(held != null)

	assert(held.try_set_held_ingredient(null))

	assert(gives != null, "expected gives to be set")
	var item := gives.instantiate() as Ingredient
	assert(item != null, "expected gives to be an Ingredient")
	held.try_set_held_ingredient(item)


func interact_forced() -> void:
	pass
