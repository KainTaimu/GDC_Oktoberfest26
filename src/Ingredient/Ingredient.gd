class_name Ingredient
extends Node

signal on_changed

@export var base_ingredient_name: String:
	get:
		return base_ingredient_name
	set(v):
		base_ingredient_name = v
		on_changed.emit()
@export var actions_mapping: Dictionary[AbstractStation.Types, AbstractIngredientModifier]

var ingredient_name:
	get:
		return "%s %s" % [" ".join(_modifiers.map(func(x: AbstractIngredientModifier): return x.get_modifier_name())), base_ingredient_name]
var _modifiers: Array[AbstractIngredientModifier]:
	get:
		var found: Array = get_children().filter(
			func(x):
				return x is AbstractIngredientModifier
		)
		assert(found as Array[AbstractIngredientModifier] != null, "")
		return found as Array[AbstractIngredientModifier]


func try_station_action(station: AbstractStation):
	var result := actions_mapping[station.station_type].try_apply_modifier()
	CustomLogger.log_debug("action %s: %s" % [station, "ok" if result else "no"])


## returns true if this ingredient has at least one of 'type' modifier that is also active.
func has_modifier(type: AbstractIngredientModifier.Type) -> bool:
	# TODO: Uses magic string at call sites.
	return _modifiers.any(func(x: AbstractIngredientModifier): return x.get_modifier_type() == type && x.active)


func _to_string() -> String:
	return "Ingredient(%s)" % base_ingredient_name
