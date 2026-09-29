class_name FsmStateGoingHome
extends AbstractFsmState

@export var _state_name: StringName = &"going_home"
@export var owner_node: Node2D
@export var owner_sprite: Node2D
@export var owner_col_shape: CollisionShape2D


func start() -> void:
	var tween := create_tween().set_ease(Tween.EASE_IN)
	tween.tween_property(owner_sprite, "self_modulate", Color.TRANSPARENT, 1)
	tween.tween_interval(1)
	tween.tween_callback(owner_node.queue_free)


func end() -> void:
	pass


func process(_delta: float):
	pass


func get_state_name() -> StringName:
	return _state_name
