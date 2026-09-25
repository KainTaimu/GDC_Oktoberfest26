@abstract
class_name AbstractIngredientModifier
extends Node

@export var _modifier_name: StringName
@export var _modifier_type: Type = Type.NONE

var active: bool
var modifier_name: StringName:
	get:
		return _modifier_name
var modifier_type: Type:
	get:
		return _modifier_type

# NOTE: MUST ADD AN ENTRY EVERY FOR EVERY INGREDIENTMODIFIER
enum Type { NONE, CHOPPED, POURED }


@abstract
func try_apply_modifier() -> bool


@abstract
func get_modifier_name() -> StringName


func get_modifier_type() -> Type:
	return _modifier_type
