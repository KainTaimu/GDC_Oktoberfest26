class_name BuyItemHeld
extends Node2D

signal on_item_placed

static var instance: BuyItemHeld


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var motion := event as InputEventMouseMotion
		assert(motion != null)
		# global_position = motion.global_position
		global_position = motion.global_position.snapped(Vector2.ONE * 32)
	elif event is InputEventMouseButton:
		assert(StationsOrganizer.instance != null, "expected StationsOrganizer singleton to be set")
		var button := event as InputEventMouseButton
		assert(button != null)
		if !button.is_pressed():
			return
		if button.button_index == MouseButton.MOUSE_BUTTON_RIGHT:
			queue_free()
			return
		if button.button_index != MouseButton.MOUSE_BUTTON_LEFT:
			return
		on_item_placed.emit()
		queue_free()

	elif event is InputEventKey:
		if not event.is_action_pressed("ui_cancel"):
			return
		queue_free()


func _ready() -> void:
	if BuyItemHeld.instance != null:
		BuyItemHeld.instance.queue_free()
	BuyItemHeld.instance = self


func _exit_tree() -> void:
	BuyItemHeld.instance = null
