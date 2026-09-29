class_name LevelDataSceneProxy
extends Node

@export var initial_money: int = 80
@export_category("Debug")
@export var debug_initial_money: int = INT32_MAX


func _ready() -> void:
	if OS.has_feature("prod"):
		LevelData.money = initial_money
	else:
		LevelData.money = debug_initial_money
	LevelData.local_level_data = self


func _exit_tree() -> void:
	LevelData.reset.call_deferred()
