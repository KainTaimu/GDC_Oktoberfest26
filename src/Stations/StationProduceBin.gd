extends AbstractStation

func interact() -> void:
	CustomLogger.log_debug("opening produce bin")
	var held := LevelData.main_player.held_ingredient
	assert(held != null)

	assert(held.try_set_held_ingredient(null))

	var mash := load("uid://diwo8aoje52l3").instantiate() as Ingredient
	held.try_set_held_ingredient(mash)
