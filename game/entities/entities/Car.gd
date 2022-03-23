extends Node2D

enum CarType {NORMAL, NORMAL2, LARGE, SPEED}
export var cell_sprite: Vector2 = Vector2(16 , 16)
export(CarType) var type: int = CarType.NORMAL

onready var sprite := $Sprite
onready var area := $Area2D
onready var collision := $Area2D/CollisionShape2D


var velocity: Vector2 = Vector2.ZERO
var type_data: Dictionary = {
	CarType.NORMAL: { "region":Rect2(3*cell_sprite.x,0,cell_sprite.x,cell_sprite.y),
					  "area_extend": Vector2(cell_sprite.x / 2, cell_sprite.y / 2)},
	CarType.NORMAL2: { "region":Rect2(4*cell_sprite.x,0,cell_sprite.x,cell_sprite.y),
					  "area_extend": Vector2(cell_sprite.x / 2, cell_sprite.y / 2)},
	CarType.SPEED: { "region":Rect2(5*cell_sprite.x,0,cell_sprite.x,cell_sprite.y),
					  "area_extend": Vector2(cell_sprite.x / 2, cell_sprite.y / 2)},
	CarType.LARGE: { "region":Rect2(0,0,3*cell_sprite.x,cell_sprite.y),
					  "area_extend": Vector2(3*cell_sprite.x / 2, cell_sprite.y / 2)},
}

func _ready() -> void:
	sprite.region_rect = type_data[type]["region"]
	var shape: RectangleShape2D = RectangleShape2D.new()
	shape.extents = type_data[type]["area_extend"] + Vector2(0,-4)
	collision.shape = shape
	collision.set_deferred("disabled", false)

func _physics_process(delta: float) -> void:
	position += velocity * delta

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
