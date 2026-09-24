class_name StationCookingPot
extends AbstractStation

func interact() -> void:
	var held := LevelData.main_player.find_child("PlayerHeldIngredient") as PlayerHeldIngredient
	if held == null:
		CustomLogger.log_debug("no held ingredient")
		return
	var ingredient := held.held_ingredient
	if ingredient == null:
		CustomLogger.log_debug("cant cook: no held item")
		return
	ingredient.try_station_action(self)
