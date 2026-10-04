@tool
extends MarginContainer

const a := 15
const b := 90
const E := 2.718281828459045235360287471352

@export var item_name: StringName:
	get:
		return item_name
	set(v):
		item_name = v
		name = v
		if _name_label != null:
			_name_label.set_deferred("text", v)
@export var item_price: int:
	get:
		return item_price
	set(v):
		item_price = v
		if _price_label != null:
			_price_label.set_deferred("text", "$%s" % v)
@export var item_icon: Texture2D:
	get:
		return item_icon
	set(v):
		item_icon = v
		if _icon != null:
			_icon.set_deferred("texture", v)
@export var item_scene: PackedScene
@export_group("Internal")
@export var _name_label: RichTextLabel
@export var _price_label: RichTextLabel
@export var _icon: TextureRect
@export var _held_item_scene: PackedScene = preload("uid://vojbxj0sf2cg")
@export var _helper_path_hint: PackedScene = preload("uid://efulxxbgqdrq")

var item_scene_instance: Node
var col: Color = Color.WHITE
var col_tween: Tween
var _mouse_inside: bool
var _helper_hint: HelperPathHint
var _shake: float


func _ready() -> void:
	_name_label.set_deferred("text", item_name)
	_icon.set_deferred("texture", item_icon)
	_price_label.set_deferred("text", "$%s" % item_price)


func _process(delta: float) -> void:
	_shake = max(0, _shake - delta)
	offset_transform_rotation = (E ** (-a * (3 - _shake))) * cos(b * (3 - _shake)) * randf_range(0.2, 0.5)


func _input(event: InputEvent) -> void:
	if !(event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and
			_mouse_inside and not event.is_echo()):
		return
	if BuyItemHeld.instance != null:
		BuyItemHeld.instance.queue_free()

	item_scene_instance = item_scene.instantiate()
	create_buy_item_held()
	if _helper_path_hint != null and item_scene_instance is Npc:
		_create_helper_path_hint()


func _draw() -> void:
	var rect := get_rect()
	rect.position = Vector2(0, 0)
	if _mouse_inside:
		draw_rect(rect.grow(-1), col, false, 1)


func create_buy_item_held():
	if LevelData.money < item_price:
		col = Color.RED
		if col_tween != null:
			col_tween.kill()
		col_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
		col_tween.tween_property(self, "col", Color.WHITE, 3)
		_shake = 3
		return
	var scene := _held_item_scene.instantiate() as BuyItemHeld
	scene.global_position = get_global_mouse_position()
	scene.on_item_placed.connect(_on_item_placed)
	scene.on_item_canceled.connect(_on_item_canceled)
	scene.icon = item_icon
	add_child(scene)
	LevelData.money -= item_price


func _create_helper_path_hint():
	var helper := item_scene_instance as Npc
	assert(helper != null)

	var state := helper.fsm.current_state as FsmStateWaitingForWork
	if state == null:
		return

	var hint := _helper_path_hint.instantiate() as HelperPathHint
	assert(hint != null)

	hint.set_routes(state.station_routes)
	add_child(hint)
	_helper_hint = hint


func _on_item_placed():
	# using global_position doesn't work because BuyItemHeld is in its own CanvasLayer
	item_scene_instance.global_position = get_viewport().get_camera_2d().get_global_mouse_position().snapped(Vector2.ONE * 32)
	if item_scene_instance is AbstractStation:
		StationsOrganizer.instance.add_child(item_scene_instance)
	elif item_scene_instance is Npc:
		HelpersOrganizer.instance.add_child(item_scene_instance)
	else:
		assert(false, "unexpected scene type")
		item_scene_instance.queue_free()
		if _helper_hint != null:
			_helper_hint.queue_free()


func _on_item_canceled():
	LevelData.money += item_price


func _on_mouse_entered() -> void:
	_mouse_inside = true
	queue_redraw()


func _on_mouse_exited() -> void:
	_mouse_inside = false
	queue_redraw()
