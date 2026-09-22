extends AbstractPlayerMovementController

@export var _player_node: Player
@export var speed: float = 600
@export var rev_per_sec: float = 1

var angle: float = 0


func _physics_process(_delta: float) -> void:
	_move()


func _move():
	var delta := get_physics_process_delta_time()
	var move_x := speed * sin(angle) * delta
	_player_node.global_position += Vector2(move_x, 0)
	_player_node.velocity = Vector2(move_x, 0)

	angle += rev_per_sec * delta
