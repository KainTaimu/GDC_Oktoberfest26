class_name HelperPathHint
extends CanvasLayer

@export var routes: RecipeRoute
@export var drawer: HelperPathHintDrawer

var enabled: bool
var paths: Array[Vector2] = []


func set_routes(r: RecipeRoute) -> void:
	enabled = r != null
	routes = r
	drawer.set_routes(r)
