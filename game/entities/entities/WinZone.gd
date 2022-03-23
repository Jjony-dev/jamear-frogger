extends Node2D

export var trap_active: bool = false

onready var sprite := $Sprite
onready var animation := $AnimationPlayer

var reached: bool = false

func _ready() -> void:
	reset()
	
func reset():
	reached = false
	sprite.visible = false

func active_trap() -> void:
		animation.play("TrapAppear")

func _on_Area2D_body_entered(body: Node) -> void:
	var object: Node2D = body.owner
	if object is Frog:
		if not reached and not trap_active:
			reached = true
			sprite.visible = true
			object.zone_reached()
		else:
			object.hit()
