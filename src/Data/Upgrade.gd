@tool
class_name Upgrade
extends Resource

@export var display_name: StringName

## The name of the Stat property to modify
@export var property_name: StringName
@export var stat: Stat = Stat.new()


func apply(to: Object):
	to.set(property_name, stat)
