@tool
class_name RecipeStepIngredient
extends AbstractRecipeStep

@export var ingredient: StringName
@export var quantity: int
@export var minigame_scene: PackedScene


func _init() -> void:
	resource_local_to_scene = true


func start_minigame():
	var minigame := minigame_scene.instantiate() as AbstractRecipeMinigame
	assert(minigame != null, "expected AbstractRecipeMinigame, got %s" % minigame.get_class())
