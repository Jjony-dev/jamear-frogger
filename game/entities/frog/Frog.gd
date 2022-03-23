extends Node2D
class_name Frog

signal life_lost(p_id)
signal target_reached

export var MOVE_DISTANCE = 16
export(float, 0.1, 5) var SPEED_MOVE: float = 1
export var player_id : int = 1

onready var sprite := $Sprite
onready var tween := $Tween
onready var animation := $AnimationPlayer
onready var sfx_jump := $Jump
onready var sfx_death := $Death
onready var body := $Body
onready var collision := $Body/CollisionShape2D
onready var is_valid := $IsValid

var controller: Node = null
var current_move: Vector2 = Vector2.ZERO
var is_moving: bool = false
var velocity: Vector2 = Vector2.ZERO
var time_move: float

func _ready() -> void:
	animation.playback_speed = SPEED_MOVE
	time_move = 1/SPEED_MOVE
	
func _unhandled_input(_event: InputEvent) -> void:
	current_move.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	current_move.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	is_valid.cast_to = current_move * MOVE_DISTANCE

func move() -> void:
	if not is_moving and not is_valid.is_colliding():
		if current_move.y != 0:
			animation.play("JumpUp" if current_move.y < 0 else "JumpDown")
			is_moving = true
			tween.interpolate_property(self, "position",\
					position, Vector2(position.x, position.y + current_move.y * MOVE_DISTANCE),\
					time_move, Tween.TRANS_CUBIC)
			sfx_jump.play()
		elif current_move.x != 0:
			sprite.flip_h = current_move.x < 0 
			animation.play("JumpRight")
			is_moving = true
			tween.interpolate_property(self, "position",\
					position, Vector2(position.x + current_move.x * MOVE_DISTANCE + velocity.x * time_move, position.y),\
					time_move, Tween.TRANS_CUBIC)
			sfx_jump.play()
		tween.start()

func reset(g_position) -> void:
	global_position = g_position
	tween.remove_all()
	animation.play("RESET")
	current_move = Vector2.ZERO
	is_moving = false
	set_process_unhandled_input(true)
	set_physics_process(true)

func hit() -> void:
	collision.set_deferred("disabled", true)
	animation.play("Death")
	tween.remove_all()
	set_process_unhandled_input(false)
	set_physics_process(false)
	current_move = Vector2.ZERO
	sfx_death.play()

func zone_reached() -> void:
	emit_signal("target_reached")

func _physics_process(delta: float) -> void:
	position += velocity * delta
	is_valid.force_raycast_update()
	move()


func _on_Tween_tween_all_completed() -> void:
	is_moving = false

func add_velocity(extra_vel: Vector2) -> void:
	velocity += extra_vel

func remove_velocity(extra_vel: Vector2) -> void:
	velocity -= extra_vel



func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	match anim_name:
		"Death":
			emit_signal("life_lost", player_id)
		"JumpUp":
			animation.play("IdleUp")
		"JumpDown":
			animation.play("IdleDown")
		"JumpRight":
			animation.play("IdleRight")
		
