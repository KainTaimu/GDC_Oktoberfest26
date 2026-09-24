extends Node

signal on_money_changed(new_value: int, previous_value: int)

var main_player: Player
var money: int:
	get:
		return money
	set(v):
		var old := money
		money = v
		on_money_changed.emit(v, old)


func reset():
	money = 0
	main_player = null
