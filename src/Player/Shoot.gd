extends RayCast2D


func _input(event: InputEvent) -> void:
	var mouse := event as InputEventMouse
	if mouse == null:
		return
	if mouse.button_mask != MouseButton.MOUSE_BUTTON_LEFT:
		return
	target_position = get_global_mouse_position()
	var npc := get_collider() as Npc
	if npc == null:
		return
	npc.queue_free()
