class_name StationsOrganizer
extends Node2D

static var instance: StationsOrganizer


func _ready() -> void:
	StationsOrganizer.instance = self


func _exit_tree() -> void:
	StationsOrganizer.instance = null
