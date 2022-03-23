extends Node2D


onready var homes := $WinZones.get_children()
onready var timer := $TimerTrap


func _ready() -> void:
	reset()
	
func reset(loop: int = 0) -> void:
	for h in homes:
		h.reset()
	if loop > 0:
		timer.wait_time = 6 - loop
		timer.start()

func is_complete() -> bool:
	var count: int = 0
	for h in homes:
		if not h.reached:
			break
		count += 1
	return count == homes.size()


func _on_Timer_timeout() -> void:
	var home_selected = homes[randi() % homes.size()]
	if not home_selected.reached:
		home_selected.active_trap()
	timer.start()
