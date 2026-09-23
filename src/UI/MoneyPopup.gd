extends Node2D

@export var _money_popup_label_scene: PackedScene = preload("uid://boy4dpw6345p8")


func _ready() -> void:
	LevelData.on_money_changed.connect(_spawn_popup)


func _spawn_popup(new_value: int, old_value: int):
	var popup := _money_popup_label_scene.instantiate() as Label
	var diff := new_value - old_value
	var diff_sign := "+" if diff >= 0 else "-"
	popup.text = "%s$%s" % [diff_sign, abs(diff)]
	add_child(popup)

	var tween := popup.create_tween().set_ease(Tween.EASE_OUT)
	tween.set_parallel(true)
	tween.tween_property(popup, "position", Vector2(0, -randf_range(20, 50)), 1.0)
	tween.tween_property(popup, "self_modulate", Color.TRANSPARENT, 1.0)
	tween.set_parallel(false)
	tween.tween_callback(popup.queue_free)
