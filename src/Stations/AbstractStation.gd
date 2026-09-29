@abstract
class_name AbstractStation
extends Node2D

signal on_progress_changed(new_value: float)

enum Types { NONE, CHOPPING_BOARD, COOKING_POT, M_POTATO_STAND, PRODUCE_BIN, BEER_KEG, MUG_CRATE, BEER_STAND }

const TYPE_NAMES: Dictionary[Types, StringName] = {
	Types.CHOPPING_BOARD: &"Chopping board",
	Types.COOKING_POT: &"Cooking pot",
	Types.M_POTATO_STAND: &"Mashed potato stand",
	Types.PRODUCE_BIN: &"Produce bin",
	Types.BEER_KEG: &"Beer keg",
	Types.MUG_CRATE: &"Beer mug crate",
	Types.BEER_STAND: &"Beer stand",
}

@export var station_type: Types


@abstract
func interact() -> void


@abstract
func interact_forced() -> bool
