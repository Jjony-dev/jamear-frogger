extends Control

const MAX_DIFICULT = 4

onready var frog := $Frog
onready var init_pos := $InitialPosition
onready var info_label := $CenterContainer/InfoLabel
onready var timer_info := $CenterContainer/Timer
onready var hub_bottom := $HUDBottom
onready var homes := $TileMap/Homes
onready var rows := $TileMap/Rows

var lifes : int = 3
var loops: int = 0
var game_over: bool = false
var extra_life: int = 20000


func _ready() -> void:
	randomize()
	set_process_input(false)
	hub_bottom.update_lifes(lifes)
	hub_bottom.update_loops(loops)
	rows.updates_rows(min(loops, MAX_DIFICULT))
	hub_bottom.time_start()
	PersistenceData.last_score = 0
	resetFrog()
	if OS.get_name() != "Android" and OS.get_name() != "iOS":
		$SwipeScreenArea.queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_type():
		var err = get_tree().change_scene("res://game/screens/Menus/Intro.tscn")
		if err != OK:
			print_debug("Error retorno a intro")

func resetFrog() -> void:
	frog.reset(init_pos.global_position)

func add_score(pts: int) -> void:
	PersistenceData.last_score += pts
	if PersistenceData.last_score > extra_life:
		extra_life += 20000
		lifes += 1
		hub_bottom.update_lifes(lifes)

func gameOver() -> void:
	game_over = true
	hub_bottom.time_pause()
	info_label.text = "GAME OVER"
	info_label.visible = true
	PersistenceData.update_data()
	timer_info.start()

func _on_Row_first_time_reached() -> void:
	add_score(10)

func _on_Frog_target_reached() -> void:
	#Cada vez
	hub_bottom.time_pause()
	var time_left: int =  hub_bottom.get_time_left()
	add_score(50 + time_left * 10)
	info_label.text = "time left %d" % time_left
	info_label.visible = true
	timer_info.start()
	rows.clear_first_time()
	#Al completar loop
	if homes.is_complete():
		loops += 1
		homes.reset(min(loops, MAX_DIFICULT))
		hub_bottom.update_loops(loops)
		rows.updates_rows(min(loops,MAX_DIFICULT))
		add_score(1000)
	resetFrog()
	hub_bottom.time_start()

func _on_Frog_life_lost(_p_id) -> void:
	lifes -= 1
	if lifes >= 0:
		resetFrog()
		hub_bottom.time_start()
		hub_bottom.update_lifes(lifes)
	else:
		gameOver()

func _on_Timer_timeout() -> void:
	info_label.visible = false
	set_process_input(game_over)

func _on_HUDBottom_timeout() -> void:
	frog.hit()
	info_label.text = "timeout"
	info_label.visible = true
	timer_info.start()

func _on_DeathZone_body_entered(body: Node) -> void:
	if body.owner is Frog:
		frog.hit()
