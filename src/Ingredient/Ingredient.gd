class_name Ingredient
extends Node

signal on_changed

@export var base_ingredient_name: StringName:
	get:
		return base_ingredient_name
	set(v):
		ingredient_name = v
		on_changed.emit()
@export var name_modifiers: Array[String] = []:
	get:
		return name_modifiers
	set(v):
		name_modifiers = v
		on_changed.emit()
@export var actions_mapping: Dictionary[AbstractStation.Types, AbstractActionBehavior]

var ingredient_name:
	get:
		name_modifiers.sort()
		return "%s %s" % [" ".join(name_modifiers), base_ingredient_name]


func try_station_action(station: AbstractStation):
	var result := actions_mapping[station.station_type].try_perform_action()
	CustomLogger.log_debug("action %s" % result)


func _to_string() -> String:
	return "Ingredient(%s)" % base_ingredient_name
