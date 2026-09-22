@abstract
class_name AbstractInteractable
extends Node2D

signal on_interacted

@export var interact_behavior: AbstractInteractBehavior


@abstract
func interact()
