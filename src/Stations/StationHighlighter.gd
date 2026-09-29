extends Node

@onready var parent: Node2D = $".."


func highlight(on: bool):
	parent.modulate = Color.WHITE
	pass
