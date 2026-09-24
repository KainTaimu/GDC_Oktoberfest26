class_name IngredientModifierChopped
extends AbstractIngredientModifier

var chopped: bool


func try_apply_modifier() -> bool:
	if chopped:
		return false
	chopped = true
	active = true
	return true


func get_modifier_name() -> StringName:
	return modifier_name if chopped else &""
