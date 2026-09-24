@tool
class_name Inventory
extends CanvasLayer

@export var _body: Control
@export var _main_panel: Control
@export var _close_button: Button

@export var show_time: float = 0.5

var _shown: bool = true
var _move_tween: Tween
var _default_body_position: Vector2


func _ready() -> void:
	if Engine.is_editor_hint():
		hide()
		return
	show()
	_default_body_position = _body.position


func toggle_show():
	if _shown:
		hide_inventory()
	else:
		show_inventory()


func show_inventory():
	_shown = true
	if _move_tween != null:
		_move_tween.kill()
	_move_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	_move_tween.tween_property(_body, "position", _default_body_position, show_time)
	_close_button.text = "<"


func hide_inventory():
	_shown = false
	if _move_tween != null:
		_move_tween.kill()
	_move_tween = create_tween().set_trans(Tween.TRANS_QUAD)
	_move_tween.tween_property(_body, "position", Vector2(-_main_panel.size.x, _default_body_position.y), show_time)
	_close_button.text = ">"
