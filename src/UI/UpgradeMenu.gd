class_name UpgradeMenu
extends VFlowContainer

@export var _button_v_box: BoxContainer

var button_script := preload("uid://bw4d4h8shuaq8")

var shown: bool


func toggle_menu(upgrades: Array[Upgrade]):
	if not shown:
		show()
		for child in _button_v_box.get_children():
			child.queue_free()

		for upgrade in upgrades:
			var button := button_script.new()
			button.set_upgrade(upgrade)
			add_child(button)
		return

	hide()
