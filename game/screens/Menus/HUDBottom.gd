extends Container
signal timeout

onready var time_bar := $Background/VBoxContainer/HBoxContainer2/ProgressBar
onready var lifes_UI := $Background/VBoxContainer/HBoxContainer/Lifes
onready var loops_UI := $Background/VBoxContainer/HBoxContainer/Loops

func _ready() -> void:
	set_process(false)

func _process(delta: float) -> void:
	time_bar.value += delta

func update_lifes(amount: int) -> void:
	lifes_UI.text = "Lifes x %d" % amount

func update_loops(amount: int) -> void:
	loops_UI.text = "Loops x %d" % amount

func time_start() -> void:
	time_reset()
	set_process(true)

func time_pause() -> void:
	set_process(false)

func time_continue() -> void:
	set_process(true)

func time_reset() -> void:
	time_bar.value = 0

func get_time_left() -> int:
	var time_left: float
	set_process(false)
	time_left = time_bar.max_value - time_bar.value
	time_reset()
	return int(time_left)

func _on_ProgressBar_value_changed(value: float) -> void:
	if value >= time_bar.max_value:
		emit_signal("timeout")
		set_process(false)
