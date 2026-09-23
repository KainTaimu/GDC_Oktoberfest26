extends Node

func _exit_tree() -> void:
	LevelData.reset.call_deferred()
