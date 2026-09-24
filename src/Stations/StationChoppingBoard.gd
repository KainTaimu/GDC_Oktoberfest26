extends AbstractStation

func interact() -> void:
	var held := LevelData.main_player.find_child("PlayerHeldIngredient") as PlayerHeldIngredient
	if held == null:
		CustomLogger.log_debug("no held ingredient")
		return
	held.held_ingredient.try_station_action(self)
	CustomLogger.log_debug(held)
