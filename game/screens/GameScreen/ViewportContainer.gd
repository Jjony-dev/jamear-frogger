extends ViewportContainer

onready var viewport := $Viewport


func _ready() -> void:
	_on_Viewport_size_changed()

func _on_Viewport_size_changed() -> void:
	pass
#	camera.zoom = Vector2(1,1.5) * max(208 / viewport.size.x, 288 / viewport.size.y)
