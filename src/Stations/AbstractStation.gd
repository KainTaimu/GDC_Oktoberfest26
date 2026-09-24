@abstract
class_name AbstractStation
extends Node2D

signal on_progress_changed(new_value: float)

enum Types { NONE, CHOPPING_BOARD, COOKING_POT, MASHED_POTATO_STAND }

@export var station_type: Types


@abstract
func interact() -> void
