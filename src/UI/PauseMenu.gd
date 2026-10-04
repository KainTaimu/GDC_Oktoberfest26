extends CanvasLayer

var tree: SceneTree:
	get:
		return get_tree()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()


func _ready() -> void:
	hide()


func toggle_pause():
	if tree.paused:
		unpause()
	else:
		pause()


func pause():
	tree.paused = true
	show()


func unpause():
	tree.paused = false
	hide()
