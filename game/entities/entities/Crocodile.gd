extends BaseEntity

func _physics_process(delta: float) -> void:
	position += velocity * delta

func _on_HitArea_body_entered(body: Node) -> void:
	var object: Node2D = body.owner
	if object is Frog:
		object.hit()
