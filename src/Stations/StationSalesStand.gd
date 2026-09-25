@tool
class_name StationSalesStand
extends AbstractStation

signal on_sale_complete(earned_money: int)

@export var sells_what: Ingredient.Types
@export var label_name: StringName:
	get:
		return label_name
	set(v):
		label_name = v
		_label.text = v

@export var items_per_interaction: Stat
@export var seconds_per_item: Stat
@export var money_per_item: Stat

@export_group("Internal")
@export var _label: Label

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
	on_sale()


func interact() -> void:
	var held := LevelData.main_player.held_ingredient
	var ingredient := held.get_held_ingredient()
	if ingredient == null:
		CustomLogger.log_debug("cant sell: not holding anything")
		return
	if ingredient.ingredient_type != sells_what:
		CustomLogger.log_debug("cant sell: held item not supported")
		return
	held.try_set_held_ingredient(null)
	quantity += roundi(items_per_interaction.value)


func interact_forced() -> void:
	quantity += roundi(items_per_interaction.value)


func on_sale() -> void:
	quantity -= 1
	on_sale_complete.emit(roundi(money_per_item.value))
