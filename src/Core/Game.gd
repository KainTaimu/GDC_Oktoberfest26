extends Node

func _input(_event: InputEvent) -> void:
	if OS.has_feature("prod"):
		return

	if Input.is_action_pressed("DEBUG_EXIT_GAME"):
		get_tree().quit()
	elif Input.is_physical_key_pressed(KEY_F12):
		get_tree().reload_current_scene.call_deferred()
