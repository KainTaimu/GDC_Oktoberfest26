class_name IngredientModifierCooked
extends AbstractIngredientModifier

func try_apply_modifier() -> bool:
	var parent := get_parent() as Ingredient
	assert(parent != null, "expected parent to be Ingredient")
	if not parent.has_modifier(Type.CHOPPED):
		CustomLogger.log_debug("cant cook: not chopped")

	var mashed_scene := load("uid://u85y0onbn35r") as PackedScene
	var mashed := mashed_scene.instantiate()

	var held := LevelData.main_player.find_child("PlayerHeldIngredient") as PlayerHeldIngredient
	held.add_child(mashed)
	held.held_ingredient = mashed

	CustomLogger.log_debug("cook mashed potatoes success")
	parent.queue_free()
	return true


func get_modifier_name() -> StringName:
	return modifier_name
