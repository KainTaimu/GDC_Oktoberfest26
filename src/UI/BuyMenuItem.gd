@tool
extends MarginContainer

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

var _mouse_inside: bool


func _ready() -> void:
	_name_label.set_deferred("text", item_name)
	_icon.set_deferred("texture", item_icon)
	_price_label.set_deferred("text", "$%s" % item_price)


func _input(event: InputEvent) -> void:
	if !(event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and
			_mouse_inside and not event.is_echo()):
		return
	if BuyItemHeld.instance != null:
		BuyItemHeld.instance.queue_free()
	create_buy_item_held()


func create_buy_item_held():
	var scene := _held_item_scene.instantiate() as BuyItemHeld
	scene.global_position = get_global_mouse_position()
	scene.on_item_placed.connect(_on_item_placed)
	add_child(scene)


func _on_item_placed():
	var scene := item_scene.instantiate()
	# using global_position doesn't work because BuyItemHeld is in its own CanvasLayer
	scene.global_position = get_viewport().get_camera_2d().get_global_mouse_position().snapped(Vector2.ONE * 32)
	if scene is AbstractStation:
		StationsOrganizer.instance.add_child(scene)
	elif scene is Helper:
		HelpersOrganizer.instance.add_child(scene)
	else:
		assert(false, "unexpected scene type")
		scene.queue_free()


func _draw() -> void:
	var rect := get_rect()
	rect.position = Vector2(0, 0)
	if _mouse_inside:
		draw_rect(rect.grow(-1), Color.WHITE, false, 1)


func _on_mouse_entered() -> void:
	_mouse_inside = true
	queue_redraw()


func _on_mouse_exited() -> void:
	_mouse_inside = false
	queue_redraw()
