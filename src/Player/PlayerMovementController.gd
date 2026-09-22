extends AbstractPlayerMovementController

@export var _player_node: Player
@export var _player_stats: PlayerStats
@export var _player_sprite: AnimatedSprite2D


func _physics_process(_delta: float) -> void:
	_move()
	if Engine.get_process_frames() % 10:
		_flip_sprite()


func _move():
	var move_vec := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_vec *= _player_stats.move_speed.value
	_player_node.velocity = move_vec
	_player_node.move_and_slide()


func _flip_sprite():
	var vp := get_viewport()
	var center := vp.get_visible_rect().get_center()
	var mouse_pos := vp.get_mouse_position()
	var should_flip := mouse_pos.x > center.x
	_player_sprite.flip_h = !should_flip
