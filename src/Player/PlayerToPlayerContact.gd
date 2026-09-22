class_name PlayerToPlayerContact
extends Area2D

signal on_player_collision(collision: PlayerCollisionData)

@export var player: Player


func _on_area_entered(area: Area2D) -> void:
	var ppc := area as PlayerToPlayerContact
	if ppc == null:
		CustomLogger.log_error("contact with non PlayerToPlayerContact node when it should be able to")
		return
	var other := ppc.player
	CustomLogger.log_debug("%s collided with %s" % [player.name, other.name])

	var diff := player.velocity - other.velocity
	CustomLogger.log_debug(diff)
