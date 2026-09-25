extends AbstractStation

func interact() -> void:
	var held := LevelData.main_player.held_ingredient
	assert(held != null, "expected LevelData.main_player to have PlayerHeldIngredient")

	var ingredient := held.get_held_ingredient()
	if ingredient == null:
		CustomLogger.log_debug("cant pour beer: no held item")
		return

	ingredient.try_station_action(self)


func interact_forced() -> void:
	pass
