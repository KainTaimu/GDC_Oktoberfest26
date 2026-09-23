@tool
class_name Stat
extends Resource

var value: float:
	get:
		return (base_value + _sum_or_default(flat)) * _sum_or_default(multipliers, 1)
@export var base_value: float = 0
@export var flat: Array[float] = []
@export var multipliers: Array[float] = []


func _init():
	resource_local_to_scene = true


func _to_string() -> String:
	return "%s ([%s + %s] * %s)" % [value, base_value, _sum_or_default(flat), _sum_or_default(multipliers, 1)]


static func sum(accum, number) -> float:
	return accum + number


static func _sum_or_default(arr: Array, default: float = 0):
	var s = arr.reduce(sum)
	if s == null:
		return default
	return s as float
