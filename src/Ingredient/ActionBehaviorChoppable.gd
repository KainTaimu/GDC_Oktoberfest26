class_name ActionBehaviorChoppable
extends AbstractActionBehavior

@export var ingredient_parent: Ingredient

var chopped: bool


func try_perform_action() -> bool:
	if chopped:
		return false
	chopped = true
	ingredient_parent.name_modifiers.append("Chopped")
	return true
