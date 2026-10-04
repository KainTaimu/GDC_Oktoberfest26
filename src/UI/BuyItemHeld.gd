@tool
class_name BuyItemHeld
extends Node2D

signal on_item_placed
signal on_item_canceled

static var instance: BuyItemHeld

@export var item_icon: TextureRect

var icon: Texture2D:
	get:
		return icon
	set(v):
		icon = v
		item_icon.texture = v


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	if BuyItemHeld.instance != null:
		BuyItemHeld.instance.queue_free()
	BuyItemHeld.instance = self


func _exit_tree() -> void:
	if Engine.is_editor_hint():
		return
	BuyItemHeld.instance = null


func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
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
			on_item_canceled.emit()
			queue_free()
			return
		if button.button_index != MouseButton.MOUSE_BUTTON_LEFT:
			return
		on_item_placed.emit()
		queue_free()
