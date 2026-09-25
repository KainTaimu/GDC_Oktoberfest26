class_name IngredientModifierBeerPoured
extends AbstractIngredientModifier

var poured: bool


func try_apply_modifier() -> bool:
	if poured:
		CustomLogger.log_debug("cant chop: already chopped")
		return false
	poured = true
	active = true
	return true


func get_modifier_name() -> StringName:
	return modifier_name if poured else &""
