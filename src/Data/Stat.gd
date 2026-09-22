@tool
class_name Stat
extends Resource

var value: float:
	get:
		return (base_value + _sum_or_one(flat)) * _sum_or_one(multipliers)
@export var base_value: float = 0
@export var flat: Array[float] = []
@export var multipliers: Array[float] = []


func _ready():
	resource_local_to_scene = true


static func sum(accum, number) -> float:
	return accum + number


static func _sum_or_one(arr: Array):
	var s = arr.reduce(sum)
	if s == null:
		return 1
	return s as float
