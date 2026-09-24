class_name StationCookingPot
extends AbstractStation

func interact() -> void:
	var held := LevelData.main_player.find_child("PlayerHeldIngredient") as PlayerHeldIngredient
	if held == null:
		CustomLogger.log_debug("no held ingredient")
		return
	var ingredient := held.held_ingredient
	if ingredient.base_ingredient_name == "Potatoes":
		_cook_pototoes(ingredient)


func _cook_pototoes(ingredient: Ingredient):
	if not ingredient.name_modifiers.has("Chopped"):
		CustomLogger.log_debug("cannot cook mashed potatoes: not chopped")
		return
	CustomLogger.log_debug("cooked")
	ingredient.queue_free()
