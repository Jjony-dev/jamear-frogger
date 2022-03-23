extends Node2D

export var own_velocity: Vector2 = Vector2(8,0)

onready var ray := $Front
onready var sprite := $Sprite

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if ray.is_colliding():
		change_direction()
	position += (velocity + own_velocity) * delta

func change_direction() -> void:
	own_velocity.x *= -1
	sprite.flip_h = own_velocity.x < 0
	ray.cast_to.x *= sign(own_velocity.x)
	
func add_velocity(extra_vel: Vector2) -> void:
	velocity += extra_vel

func remove_velocity(extra_vel: Vector2) -> void:
	velocity -= extra_vel

func reset_pos(g_position: Vector2) -> void:
	global_position = g_position


func _on_Area2D_body_entered(body: Node) -> void:
	var object: Node2D = body.owner
	if object is Frog:
		object.hit()
