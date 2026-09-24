extends AbstractIngredientModifier

func try_apply_modifier() -> bool:
	var parent := get_parent() as Ingredient
	assert(parent != null, "expected parent to be Ingredient")
	if not parent.has_modifier(Type.CHOPPED):
		CustomLogger.log_debug("cant cook: not chopped")
		return false

	var mashed_scene := load("uid://u85y0onbn35r") as PackedScene
	var mashed := mashed_scene.instantiate()

	var held := LevelData.main_player.find_child("PlayerHeldIngredient") as PlayerHeldIngredient
	assert(held.try_set_held_ingredient(null), "expected passing null to clear ingredient")
	if not held.try_set_held_ingredient(mashed):
		CustomLogger.log_debug("cant apply modifier: cannot give mashed potatoes")
		return false

	CustomLogger.log_debug("cook mashed potatoes success")
	parent.queue_free()
	return true


func get_modifier_name() -> StringName:
	return modifier_name
