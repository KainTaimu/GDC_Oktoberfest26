class_name StationCookingPot
extends AbstractStation

func interact() -> void:
	var held := LevelData.main_player.find_child("PlayerHeldIngredient") as PlayerHeldIngredient
	if held == null:
		CustomLogger.log_debug("no held ingredient")
		return
	var ingredient := held.held_ingredient
	if ingredient.base_ingredient_name == "Potatoes":
		_cook_pototoes(ingredient, held)


func _cook_pototoes(ingredient: Ingredient, held: PlayerHeldIngredient):
	if not ingredient.has_modifier(AbstractIngredientModifier.Type.CHOPPED):
		CustomLogger.log_debug("cant cook potatoes")
		return
	
	ingredient.queue_free()
	var mashed_scene := load("uid://u85y0onbn35r") as PackedScene
	var mashed := mashed_scene.instantiate()
	held.add_child(mashed)
	held.held_ingredient = mashed
	CustomLogger.log_debug("cook mashed potatoes success")
