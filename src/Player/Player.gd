class_name Player
extends CharacterBody2D

func _ready() -> void:
	LevelData.main_player = self


func _exit_tree() -> void:
	LevelData.main_player = null
