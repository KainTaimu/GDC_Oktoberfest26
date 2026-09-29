extends Node

@onready var target: Node2D = $".."


func _ready() -> void:
	var original_size := target.scale
	target.scale = Vector2.ZERO
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(target, "scale", original_size, 0.3)
	tween.tween_callback(queue_free)
