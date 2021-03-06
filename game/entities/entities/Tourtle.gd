extends BaseEntity

export var DIVE: bool = false
export var DIVE_VELOCITY: float = 10.0
export var DIVE_COOLDOWN: float = 1.0

onready var sprite := $Sprite
onready var animation := $AnimationPlayer

var dive_cooldown: float = DIVE_COOLDOWN

func _ready() -> void:
	animation.playback_speed = DIVE_VELOCITY

func _physics_process(delta: float) -> void:
	position += velocity * delta
	if not DIVE:
		return
	dive_cooldown -= delta
	if dive_cooldown < 0 and not animation.is_playing():
		dive_cooldown = DIVE_COOLDOWN
		animation.play("DiveIn")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	match anim_name:
		"DiveIn":
			animation.play("DiveOut")

func _on_Area2D_body_entered(body: Node) -> void:
	var object: Node2D = body.owner
	if object is Frog:
		object.hit()
