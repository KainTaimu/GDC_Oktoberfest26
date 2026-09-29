class_name LevelEventSpawnBoost
extends LevelEvent

@export var spawner: CustomerSpawner


func start():
	spawner.time_between_spawns.multipliers.append(0.2)
	spawner.max_customers_at_once.multipliers.append(5)
	pass


func stop():
	pass
