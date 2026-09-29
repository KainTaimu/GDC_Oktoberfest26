extends Node

@export var enabled: bool = true
@export var time_between_spawns: float = 1.0
@export var margin: float = 0
@export var npc_scenes: Array[PackedScene] = []
@export_category("Internal")

@onready var _timer: Timer = Timer.new()


func _ready() -> void:
	_timer.wait_time = time_between_spawns
	_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(_timer)
	_timer.start()


func _on_spawn_timer_timeout():
	if len(npc_scenes) == 0:
		return
	var scene := npc_scenes.pick_random() as PackedScene
	assert(scene != null, "expected npc scene to be of type PackedScene")
	var npc := scene.instantiate() as Npc
	assert(npc != null, "expected npc to be of type Npc")

	var pos: Vector2
	var i := randi() % 4 # N W E S
	var size := get_viewport().get_visible_rect().size
	var rand_x := randf_range(0, size.x)
	var rand_y := randf_range(0, size.y)
	match i:
		0: # N
			pos = Vector2(rand_x, -margin)
		1: # W
			pos = Vector2(-margin, rand_y)
		2: # E
			pos = Vector2(size.x + margin, rand_y)
		3: # S
			pos = Vector2(rand_x, size.y + margin)

	npc.global_position = pos - LevelData.main_player.global_position

	HelpersOrganizer.instance.add_child(npc)
