class_name PlayerCollisionData
extends Resource

enum CollisionSeverity { NONE, LOW, MEDIUM, HIGH }
	
var with: Player
var normal: Vector2
var force: float
var severity: CollisionSeverity = CollisionSeverity.NONE
