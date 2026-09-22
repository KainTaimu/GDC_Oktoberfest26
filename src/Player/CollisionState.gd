class_name CollisionState
extends Node

enum State { NONE, STAGGERED, DOWN }

@export var current_state: State = State.NONE
