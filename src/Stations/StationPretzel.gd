extends AbstractStation

@export var seconds_per_item: Stat
@export var money_per_item: Stat

@export var upgrade_module: UpgradeModule

var t: float


func _process(delta: float) -> void:
	t = t - delta
	if t <= 0:
		LevelData.money += roundi(money_per_item.value)
		t = wrapf(t - delta, 0, seconds_per_item.value)

	if not is_zero_approx(seconds_per_item.value):
		on_progress_changed.emit(t / seconds_per_item.value)


func interact() -> void:
	if upgrade_module == null:
		return
	upgrade_module.try_upgrade()
