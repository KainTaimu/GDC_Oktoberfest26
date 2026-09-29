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
@export var items_per_interaction_helper: Stat
@export var seconds_per_item: Stat
@export var money_per_item: Stat

@export_group("Internal")
@export var _label: Label

var quantity: int

var t: float


func _process(delta: float) -> void:
	t = max(0, t - delta)
	if not is_zero_approx(seconds_per_item.value):
		on_progress_changed.emit(t / seconds_per_item.value)

	if quantity <= 0 || quantity <= 0:
		return


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
	restock()


func interact_forced() -> bool:
	if quantity <= 0:
		return false
	on_sale()
	return true


func restock() -> void:
	quantity += roundi(items_per_interaction.value)


func on_sale() -> void:
	quantity -= 1
	t = seconds_per_item.value
	LevelData.money += roundi(money_per_item.value)
	on_sale_complete.emit(roundi(money_per_item.value))
