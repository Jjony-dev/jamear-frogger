extends Node2D

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	position += velocity * delta

func add_velocity(extra_vel: Vector2) -> void:
	velocity += extra_vel

func remove_velocity(extra_vel: Vector2) -> void:
	velocity -= extra_vel

func reset_pos(g_position: Vector2) -> void:
	global_position = g_position

func _on_HitArea_body_entered(body: Node) -> void:
	var object: Node2D = body.owner
	if object is Frog:
		object.hit()
