class_name StationMashedPotatoStand
extends AbstractStation

@export var items_per_interaction: Stat
@export var seconds_per_item: Stat
@export var money_per_item: Stat

var quantity: int

var t: float


func _process(delta: float) -> void:
	if quantity <= 0 || quantity <= 0:
		t = seconds_per_item.value
		return

	t = t - delta
	if not is_zero_approx(seconds_per_item.value):
		on_progress_changed.emit(t / seconds_per_item.value)
	if t > 0:
		return

	LevelData.money += roundi(money_per_item.value)
	t = wrapf(t - delta, 0, seconds_per_item.value)
	quantity -= 1


func interact() -> void:
	var held := LevelData.main_player.held_ingredient
	var ingredient := held.get_held_ingredient()
	if ingredient == null:
		CustomLogger.log_debug("cant sell: not holding anything")
		return
	if ingredient.base_ingredient_name != "Mashed Potatoes":
		CustomLogger.log_debug("cant sell: held item not mashed potatoes")
		return
	held.try_set_held_ingredient(null)
	quantity += roundi(items_per_interaction.value)


func interact_forced() -> void:
	quantity += roundi(items_per_interaction.value)
