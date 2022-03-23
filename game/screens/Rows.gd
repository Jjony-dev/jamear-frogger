extends Node2D

onready var rows := get_children()

func _ready() -> void:
	pass

func clear_first_time() -> void:
	for r in rows:
		r.reset()

func updates_rows(loop: int = 0) -> void:
	for r in rows:
		r.update_content(loop)
