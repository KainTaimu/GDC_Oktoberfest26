@tool
class_name UpgradeModule
extends Node

signal on_last_upgrade_set

@export var _target: Node
@export var _upgrades: Array[Upgrade] = []:
	get:
		return _upgrades
	set(v):
		_upgrades = v
		_validate_upgrades.call_deferred()

@export var _validate: bool:
	get:
		return false
	set(v):
		if not Engine.is_editor_hint():
			return
		_validate = false
		_validate_upgrades.call_deferred()

var _upgrade_index: int = -1:
	get:
		return _upgrade_index
	set(v):
		# assert(v < 0 or v >= len(_upgrades), "_upgrade_index out of range")
		_upgrade_index = v

var _last_upgrade_reached: bool


func try_upgrade():
	if _upgrade_index + 1 >= len(_upgrades):
		CustomLogger.log_debug("no more upgrades")
		if not _last_upgrade_reached:
			_last_upgrade_reached = true
			on_last_upgrade_set.emit()
		return
	_upgrade_index += 1
	var upgrade := _upgrades[_upgrade_index]
	if _upgrade_index + 1 >= len(_upgrades):
		CustomLogger.log_debug("no more upgrades")
		if not _last_upgrade_reached:
			_last_upgrade_reached = true
			on_last_upgrade_set.emit()
		return

	_set_stat(upgrade)
	CustomLogger.log_debug("upgraded %s" % _upgrade_index)


func _set_stat(upgrade: Upgrade):
	_target.set(upgrade.property_name, upgrade.stat)


func _validate_upgrades():
	for x in _upgrades:
		var property_name := x.property_name
		assert(
			_has_property_name(_target, property_name),
			"expected object %s to have property named \"%s\"" % [
				_target,
				property_name,
			],
		)
	CustomLogger.log_info("ok")


func _has_property_name(obj: Object, property_name: StringName) -> bool:
	for property in obj.get_property_list():
		if property.get("name") == property_name:
			return true
	return false
