extends Node2D
signal first_time_reached

export var H_VELOCITY: PoolRealArray = [10.0,10.0,10.0,10.0,10.0]
export(int, FLAGS, "Environment", "Players", "Enemies") var targets: int = 0
export(int, 1, 30) var cell_size: int = 16
export var content : Array = []

onready var area2D := $Area2D2
onready var collisionSeg: SegmentShape2D = $Area2D2/CollisionShape2D.shape

var is_first_time: bool = true
var reset_position: Vector2
var size: int
var current_content: Array = []
var current_velocity: float = H_VELOCITY[0]


func reset() -> void:
	is_first_time = true

func update_content(loop: int = -1):
	current_velocity = H_VELOCITY[loop]
	reset_position = global_position if current_velocity > 0 else global_position +  collisionSeg.b
	set_physics_process(false)
	if loop == -1:
		return
	if not current_content.empty():
		for n in current_content:
			remove_child(n)
			n.queue_free()
		current_content.clear()
	for i in content[loop].size():
		if content[loop][i] < 0:
			continue
#		print("Creo en %d %d = %f" % [i,cell_size,((i+1) * cell_size)])
		var temp: Node2D = EntityFactory.create_from_id(content[loop][i])
		temp.position.x = (i + 1) * cell_size
		current_content.append(temp)
		call_deferred("add_child",temp)
	set_physics_process(true)
	
func _ready() -> void:
	area2D.collision_mask = targets + 128
	reset_position = global_position if current_velocity > 0 else global_position +  collisionSeg.b

func _on_Area2D2_area_entered(area: Area2D) -> void:
	var object: Node2D = area.owner
	if object.has_method("add_velocity"):
		object.add_velocity(Vector2(current_velocity,0))


func _on_Area2D2_area_exited(area: Area2D) -> void:
	var object: Node2D = area.owner
	if object.has_method("remove_velocity"):
		object.remove_velocity(Vector2(current_velocity,0))
	if object.has_method("reset_pos"):
		object.reset_pos(reset_position)


func _on_Area2D2_body_entered(body: Node) -> void:
	var object: Node2D = body.owner
	if area2D.get_collision_mask_bit(1) and object.has_method("add_velocity"):
		object.add_velocity(Vector2(current_velocity,0))
	if object is Frog:
		if is_first_time:
			is_first_time = false
			emit_signal("first_time_reached")


func _on_Area2D2_body_exited(body: Node) -> void:
	var object: Node2D = body.owner
	if area2D.get_collision_mask_bit(1) and object.has_method("remove_velocity"):
		object.remove_velocity(Vector2(current_velocity,0))
