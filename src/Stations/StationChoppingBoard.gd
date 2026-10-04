extends AbstractStation

var ing: Ingredient


func interact() -> void:
	var held := LevelData.main_player.find_child("PlayerHeldIngredient") as PlayerHeldIngredient
	assert(held != null, "expected LevelData.main_player to have PlayerHeldIngredient")

	var ingredient := held.get_held_ingredient()
	if ingredient == null:
		CustomLogger.log_debug("cant chop: no held item")
		return

	ing = ingredient
	if ingredient.ingredient_type == ingredient.Types.POTATOES:
		if not ingredient.has_modifier(AbstractIngredientModifier.Type.CHOPPED):
			var scene := load("uid://7q6y0h7fjlie") as PackedScene
			var node := scene.instantiate() as AbstractRecipeMinigame
			node.on_minigame_completed.connect(_give)
			add_child(node)
			return

	ingredient.try_station_action(self)


func interact_forced() -> bool:
	return true


func _give(flag: bool):
	if not flag:
		return
	ing.try_station_action(self)
