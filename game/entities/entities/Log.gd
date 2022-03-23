extends Node2D

export(int, 2, 5) var LARGE = 5
export var cell_size: Vector2 = Vector2(16, 16)

onready var sprite_start := $SpriteStart
onready var sprite_medium := $SpriteMedium
onready var sprite_end := $SpriteEnd
onready var collision := $Area2D/CollisionShape2D

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	var half_x: float = cell_size.x / 2
	sprite_medium.position.x =  half_x + (LARGE - 2) * half_x
	sprite_medium.region_rect.size.x = (LARGE - 2) * cell_size.x
	sprite_end.position.x = (LARGE) * cell_size.x - cell_size.x
	var shape: RectangleShape2D = RectangleShape2D.new()
	shape.extents = Vector2(LARGE * half_x, cell_size.y / 2)
	collision.shape = shape
	collision.position = sprite_medium.position
	collision.set_deferred("disabled", false)

func _physics_process(delta: float) -> void:
	position += velocity * delta

func add_velocity(extra_vel: Vector2) -> void:
	velocity += extra_vel

func remove_velocity(extra_vel: Vector2) -> void:
	velocity -= extra_vel

func reset_pos(g_position: Vector2) -> void:
	global_position = g_position
