extends AbstractStation

@export var gives: PackedScene


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
