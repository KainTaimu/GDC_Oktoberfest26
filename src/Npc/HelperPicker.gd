extends Node2D

static var currently_picked: Node2D

@export var fsm: NpcFsm
@export_category("Internal")
@export var _help_lbl: Label

var mouse_inside: bool
var picked: bool

@onready var parent := get_parent() as Node2D


func _process(_delta: float) -> void:
	queue_redraw()


func _input(event: InputEvent) -> void:
	if not mouse_inside and not picked:
		return
	var mb := event as InputEventMouseButton
	if mb != null && mb.button_mask == MouseButton.MOUSE_BUTTON_LEFT:
		toggle_pick()
		return
	if not picked:
		return
	var mo := event as InputEventMouseMotion
	if mo == null:
		return
	parent.global_position = get_global_mouse_position()


func _draw() -> void:
	if not picked:
		return
	draw_circle(Vector2.ZERO, FsmStateGotoStation.max_station_distance, Color.GREEN, false, 1)


func toggle_pick():
	if currently_picked != null and parent != currently_picked:
		return
	picked = not picked
	_help_lbl.visible = picked
	if picked:
		fsm.transition(AbstractFsmState.States.IDLE)
		currently_picked = parent
	elif not picked:
		fsm.transition(AbstractFsmState.States.WAITING_FOR_WORK)
		currently_picked = null


func _mouse_entered() -> void:
	mouse_inside = true


func _mouse_exited() -> void:
	mouse_inside = false
