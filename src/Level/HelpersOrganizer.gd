class_name HelpersOrganizer
extends Node2D

static var instance: HelpersOrganizer


func _ready() -> void:
	HelpersOrganizer.instance = self


func _exit_tree() -> void:
	HelpersOrganizer.instance = null
