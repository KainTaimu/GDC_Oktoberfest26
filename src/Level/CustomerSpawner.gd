extends Node

@export var enabled: bool = true
@export var time_between_spawns: float = 1.0
@export var spawn_margin: float = 0
@export var npc_scenes: Array[PackedScene] = []
@export var max_customers_at_once: int = 50

@export_category("Internal")
@onready var _timer: Timer = Timer.new()
@onready var _tree: SceneTree = get_tree()


static func get_position_outside_viewport(
		margin: float = 0,
		follow_viewport_scale: bool = true,
) -> Vector2:
	var camera := LevelData.main_player.get_viewport().get_camera_2d()
	var center := camera.get_screen_center_position()
	var size := camera.get_viewport_rect().size
	if follow_viewport_scale:
		size /= camera.zoom

	var edge := randi() % 4
	match edge:
		0:
			return Vector2(
				randf_range(center.x - size.x - margin, center.x + size.x + margin),
				center.y - size.y - margin,
			)
		1:
			return Vector2(
				randf_range(center.x - size.x - margin, center.x + size.x + margin),
				center.y + size.y + margin,
			)
		2:
			return Vector2(
				center.x - size.x - margin,
				randf_range(center.y - size.y - margin, center.y + size.y + margin),
			)
		3:
			return Vector2(
				center.x + size.x + margin,
				randf_range(center.y - size.y - margin, center.y + size.y + margin),
			)
		_:
			assert(false, "selected edge is unsupported")
			return Vector2.ZERO


func _ready() -> void:
	_timer.wait_time = time_between_spawns
	_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(_timer)
	_timer.start()


func spawn():
	if len(npc_scenes) == 0:
		return
	var scene := npc_scenes.pick_random() as PackedScene
	assert(scene != null, "expected npc scene to be of type PackedScene")
	var npc := scene.instantiate() as Npc
	assert(npc != null, "expected npc to be of type Npc")

	npc.global_position = get_position_outside_viewport(spawn_margin)

	HelpersOrganizer.instance.add_child(npc)


func _on_spawn_timer_timeout():
	if _tree.get_node_count_in_group("stations_sell") == 0:
		return
	if _tree.get_node_count_in_group("customers") > max_customers_at_once:
		return
	spawn()
